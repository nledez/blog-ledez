---
title: Serveur iPXE ou comment booter sans USB/CD/whatever
lang: fr
layout: post
permalink: /informatique/serveur-ipxe-ou-comment-booter-sans-usb-cd-whatever/
categories:
  - Informatique
tags:
  - sysadmin
  - Ubuntu
excerpt_separator: <!--more-->
---
Serveur iPXE ou comment booter sans USB/CD/whatever

Avant, quand je voulais (ré)installer une machine, je gravais un CD (bien personnalisé à coup de mkisofs).
Ensuite, je suis passé aux clés USB.

Mais c'est toujours pénible :
- Il faut retrouver un média de libre
- Il faut construire une image
- Il faut graver/flasher l'image sur le média
- Booter sur le device
- Et quand ça ne fonctionne pas, repasser par la case construire l'image

Bref, ce n'est pas pratique.

On va donc passer à quelque chose de moderne comme (i)PXE.

<!--more-->

Un peu de lecture pour comprendre ce que c'est :

[Définition Wikipedia de Preboot Execution Environment](https://fr.wikipedia.org/wiki/Preboot_Execution_Environment).

TL;DR donc, pour résumer c’est :
- Le BIOS démarre
- Il passe par le firmware de la carte réseau (boot menu & NIC)
- Le firmware PXE fait une requête DHCP qui lui donne les informations
  - IP
  - Serveur BOOTP (TFTP pour simplifier)
  - Le nom de l'image avec laquelle booter
- PXE télécharge l'image en TFTP
- PXE boot l'image

Ça, c'était bien quand j'avais un NAS avec tout ce qu'il fallait comme stockage. Mais je suis passé sur un [APU2](https://pcengines.ch/apu2.htm) avec [OpenSense](https://opnsense.org/). Je suis donc passé de 6To de stockage à 13Go en SDD. Par contre, je suis aussi passé d'un ASDL faiblar à de la fibre qui met le datacenter d'[OVH](https://www.ovh.com/fr/serveurs_dedies/) dans mon salon.

Il me fallait donc une solution pour booter à partir d'une machine sur Internet.

[iPXE](http://ipxe.org/start) arrive à la rescousse. C'est une version open source (c'est un point positif) de firmware PXE. Mais surtout avec beaucoup plus de fonctionnalités (et c'est là que ça devient intéressant). Comme la possibilité de télécharger les images en HTTP à la place de TFTP.

Par contre, le firmware n'est pas forcément disponible dans les cartes réseau communes.

Ça tombe bien, on peut faire une image compatible PXE pour iPXE (Upsa powered).

Si on reprend la suite de tout à l'heure :
- PXE télécharge l'image iPXE en TFTP
- PXE boot l'image iPXE
- iPXE télécharge le reste de sa configuration en HTTP (ou autre protocole)

Il te faudra donc :
- Un serveur DHCP (sur ton routeur/firewall OpenSense)
- Un serveur TFTP (toujours ton serveur OpenSense)
- Une image iPXE (sur le serveur TFTP donc OpenSense)
- Un serveur HTTP (chez OVH ou ton serveur local)

Alors, je dis OpenSense, et le reste de l’article est basé dessus. Mais ça fonctionnera parfaitement avec PFSense, DD-WRT, un Linux installé à la “main”.

Pour générer l'image iPXE, 2 solutions :
- [Un générateur de ROM en ligne](https://rom-o-matic.eu/)
- [Compiler à partir des sources](http://git.ipxe.org/ipxe.git)

J'ai passé pas mal de temps a essayer de faire fonctionner les images générées par rom-o-matic. Mais c'était pénible de remettre la configuration, attendre la génération sur le serveur. Et puis, c'est cool de leur libérer un peu de CPU.

Mais tu peux facilement reproduire la configuration ci-dessous dans les paramètres ROM-o-Matic. Mais c’est beaucoup moins marrant :)

Bon. On y va ? Ou bien ?

# Installation du serveur iPXE

Tu fais comme tu veux. Mais moi, je mets Nginx comme serveur HTTP. Voici la configuration du virtualhost à mettre :

```nginx
server{
	listen 80;
	listen [::]:80;
        server_name ipxe.example.com pxe.example.com;

        root /var/www/ipxe;
        index index.html index.htm;
}
```

Tu vas maintenant installer tous les fichiers nécessaires à la partie iPXE :

```bash
cd /var/www
git clone https://github.com/nledez/ipxe-root ipxe
cd /var/www/ipxe
sed 's@%BOOT_URL%@http://ipxe.example.com/@;s@http://boot.smidsrod.lan/@http://ipxe.example.com/@;s@sysrcd-version 3.8.0@sysrcd-version 5.2.2@' boot.ipxe.cfg.example
mkdir boot
touch boot/.bootdir
./install.sh boot
```

# Installation des sources pour l’installeur Ubuntu

```bash
cd /var/www/ipxe
./install-ubuntu.sh
```

# Généreration du binaire iPXE

```bash
cd /var/www/ipxe
git clone git://git.ipxe.org/ipxe.git ipxe
cd ipxe/src

cat > myscript.ipxe <<EOF
#!ipxe

dhcp
chain http://ipxe.example.com/boot.ipxe
EOF

vi config/general.h
```

C'est là, ou ça prend du temps pour avoir tous les bons paramètres fonctionnels. Voilà un patch de git vs ma configuration :

```patch
diff --git a/src/config/general.h b/src/config/general.h
index 3c14a2cd..75f3a432 100644
--- a/src/config/general.h
+++ b/src/config/general.h
@@ -36,16 +36,16 @@ FILE_LICENCE ( GPL2_OR_LATER_OR_UBDL );

 #define	NET_PROTO_IPV4		/* IPv4 protocol */
 #undef	NET_PROTO_IPV6		/* IPv6 protocol */
-#undef	NET_PROTO_FCOE		/* Fibre Channel over Ethernet protocol */
-#define	NET_PROTO_STP		/* Spanning Tree protocol */
-#define	NET_PROTO_LACP		/* Link Aggregation control protocol */
+//#undef	NET_PROTO_FCOE		/* Fibre Channel over Ethernet protocol */
+//#define	NET_PROTO_STP		/* Spanning Tree protocol */
+//#define	NET_PROTO_LACP		/* Link Aggregation control protocol */

 /*
  * PXE support
  *
  */
 //#undef	PXE_STACK		/* PXE stack in iPXE - you want this! */
-//#undef	PXE_MENU		/* PXE menu booting */
+#undef	PXE_MENU		/* PXE menu booting */

 /*
  * Download protocols
@@ -55,9 +55,9 @@ FILE_LICENCE ( GPL2_OR_LATER_OR_UBDL );
 #define	DOWNLOAD_PROTO_TFTP	/* Trivial File Transfer Protocol */
 #define	DOWNLOAD_PROTO_HTTP	/* Hypertext Transfer Protocol */
 #undef	DOWNLOAD_PROTO_HTTPS	/* Secure Hypertext Transfer Protocol */
-#undef	DOWNLOAD_PROTO_FTP	/* File Transfer Protocol */
-#undef	DOWNLOAD_PROTO_SLAM	/* Scalable Local Area Multicast */
-#undef	DOWNLOAD_PROTO_NFS	/* Network File System Protocol */
+//#undef	DOWNLOAD_PROTO_FTP	/* File Transfer Protocol */
+//#undef	DOWNLOAD_PROTO_SLAM	/* Scalable Local Area Multicast */
+//#undef	DOWNLOAD_PROTO_NFS	/* Network File System Protocol */
 //#undef DOWNLOAD_PROTO_FILE	/* Local filesystem access */

 /*
@@ -85,9 +85,9 @@ FILE_LICENCE ( GPL2_OR_LATER_OR_UBDL );
  * 802.11 cryptosystems and handshaking protocols
  *
  */
-#define	CRYPTO_80211_WEP	/* WEP encryption (deprecated and insecure!) */
-#define	CRYPTO_80211_WPA	/* WPA Personal, authenticating with passphrase */
-#define	CRYPTO_80211_WPA2	/* Add support for stronger WPA cryptography */
+//#define	CRYPTO_80211_WEP	/* WEP encryption (deprecated and insecure!) */
+//#define	CRYPTO_80211_WPA	/* WPA Personal, authenticating with passphrase */
+//#define	CRYPTO_80211_WPA2	/* Add support for stronger WPA cryptography */

 /*
  * Name resolution modules
@@ -103,16 +103,16 @@ FILE_LICENCE ( GPL2_OR_LATER_OR_UBDL );
  * you want to use.
  *
  */
-//#define	IMAGE_NBI		/* NBI image support */
-//#define	IMAGE_ELF		/* ELF image support */
-//#define	IMAGE_MULTIBOOT		/* MultiBoot image support */
-//#define	IMAGE_PXE		/* PXE image support */
-//#define	IMAGE_SCRIPT		/* iPXE script image support */
-//#define	IMAGE_BZIMAGE		/* Linux bzImage image support */
-//#define	IMAGE_COMBOOT		/* SYSLINUX COMBOOT image support */
+#define	IMAGE_NBI		/* NBI image support */
+#define	IMAGE_ELF		/* ELF image support */
+#define	IMAGE_MULTIBOOT		/* MultiBoot image support */
+#define	IMAGE_PXE		/* PXE image support */
+#define	IMAGE_SCRIPT		/* iPXE script image support */
+#define	IMAGE_BZIMAGE		/* Linux bzImage image support */
+#define	IMAGE_COMBOOT		/* SYSLINUX COMBOOT image support */
 //#define	IMAGE_EFI		/* EFI image support */
-//#define	IMAGE_SDI		/* SDI image support */
-//#define	IMAGE_PNM		/* PNM image support */
+#define	IMAGE_SDI		/* SDI image support */
+#define	IMAGE_PNM		/* PNM image support */
 #define	IMAGE_PNG		/* PNG image support */
 #define	IMAGE_DER		/* DER image support */
 #define	IMAGE_PEM		/* PEM image support */
@@ -136,24 +136,24 @@ FILE_LICENCE ( GPL2_OR_LATER_OR_UBDL );
 #define LOGIN_CMD		/* Login command */
 #define SYNC_CMD		/* Sync command */
 #define SHELL_CMD		/* Shell command */
-//#define NSLOOKUP_CMD		/* DNS resolving command */
-//#define TIME_CMD		/* Time commands */
-//#define DIGEST_CMD		/* Image crypto digest commands */
-//#define LOTEST_CMD		/* Loopback testing commands */
+#define NSLOOKUP_CMD		/* DNS resolving command */
+#define TIME_CMD		/* Time commands */
+#define DIGEST_CMD		/* Image crypto digest commands */
+#define LOTEST_CMD		/* Loopback testing commands */
 //#define VLAN_CMD		/* VLAN commands */
-//#define PXE_CMD		/* PXE commands */
-//#define REBOOT_CMD		/* Reboot command */
-//#define POWEROFF_CMD		/* Power off command */
-//#define IMAGE_TRUST_CMD	/* Image trust management commands */
-//#define PCI_CMD		/* PCI commands */
-//#define PARAM_CMD		/* Form parameter commands */
-//#define NEIGHBOUR_CMD		/* Neighbour management commands */
-//#define PING_CMD		/* Ping command */
-//#define CONSOLE_CMD		/* Console command */
-//#define IPSTAT_CMD		/* IP statistics commands */
-//#define PROFSTAT_CMD		/* Profiling commands */
-//#define NTP_CMD		/* NTP commands */
-//#define CERT_CMD		/* Certificate management commands */
+#define PXE_CMD		/* PXE commands */
+#define REBOOT_CMD		/* Reboot command */
+#define POWEROFF_CMD		/* Power off command */
+#define IMAGE_TRUST_CMD	/* Image trust management commands */
+#define PCI_CMD		/* PCI commands */
+#define PARAM_CMD		/* Form parameter commands */
+#define NEIGHBOUR_CMD		/* Neighbour management commands */
+#define PING_CMD		/* Ping command */
+#define CONSOLE_CMD		/* Console command */
+#define IPSTAT_CMD		/* IP statistics commands */
+#define PROFSTAT_CMD		/* Profiling commands */
+#define NTP_CMD		/* NTP commands */
+#define CERT_CMD		/* Certificate management commands */

 /*
  * ROM-specific options
@@ -166,14 +166,14 @@ FILE_LICENCE ( GPL2_OR_LATER_OR_UBDL );
  * Virtual network devices
  *
  */
-#define VNIC_IPOIB		/* Infiniband IPoIB virtual NICs */
+//#define VNIC_IPOIB		/* Infiniband IPoIB virtual NICs */
 //#define VNIC_XSIGO		/* Infiniband Xsigo virtual NICs */

 /*
  * Error message tables to include
  *
  */
-#undef	ERRMSG_80211		/* All 802.11 error descriptions (~3.3kb) */
+//#undef	ERRMSG_80211		/* All 802.11 error descriptions (~3.3kb) */

 /*
  * Obscure configuration options
```

Maintenant, tu vas pouvoir compiler tout ça :

```bash
/var/www/ipxe/ipxe/src# make bin/undionly.kpxe
  [VERSION] bin/version.undionly.kpxe.o
  [LD] bin/undionly.kpxe.tmp
  [BIN] bin/undionly.kpxe.bin
  [ZINFO] bin/undionly.kpxe.zinfo
  [ZBIN] bin/undionly.kpxe.zbin
  [FINISH] bin/undionly.kpxe
rm bin/version.undionly.kpxe.o bin/undionly.kpxe.zinfo bin/undionly.kpxe.bin bin/undionly.kpxe.zbin
```

Et voilà, c'est terminé pour la partie iPXE.

# Maintenant, tu dois configurer le DHCP / TFTP (sur l'OpenSense)

On va commencer par DNSMasq pour la partie TFTP :

![Configuration de DNSMasq]({{ site.url }}/images/2019/05/dnsmasq-configuration.png)

Dans Service / Dnsmasq DNS / Settings :
- Cocher "Enable" si ce n'est pas fait
- "Listen port" -> "5353" ou autre chose, mais pas 53 qui rentrerait en conflit avec Unbound
- "Network interface" -> "LAN", j'ai mis ça pour éviter de répondre aux requêtes sur la partie WAN
- "Advanced" voir ci-dessous

```
enable-tftp
tftp-root=/tftp
```

Clique sur "Save". Et passes à Unbound :

![Configuration du DHCP]({{ site.url }}/images/2019/05/dhcp-configuration.png)

Dans Service / DHCPv4 / LAN :
- Dans la partie "TFTP server"
  - "Set TFTP hostname" -> "192.168.2.1"
  - "Set Bootfile" -> "/tftp/undionly.kpxe"

Et pour finir, tu vas copier le firmware que tu as construit tout à l'heure. Ouvre un shell (en ssh par exemple):

```bash
mkdir /tftp
cd /tftp/
curl http://ipxe.example.com/ipxe/src/bin/undionly.kpxe > undionly.kpxe
```

Et voilà ce que ça donne :
[Screencast de boot iPXE](https://youtu.be/to5nw1eQ7wI)

Tu peux voir le boot PXE + iPXE avec Memtest86+ puis un début d’installation Ubuntu.
