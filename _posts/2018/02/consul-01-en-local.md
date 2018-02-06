---
title: Consul 01 - en local
lang: fr
layout: post
permalink: /informatique/devops/consul-01-en-local/
categories:
  - DevOps
tags:
  - devops
  - consul
excerpt_separator: <!--more-->
---
![PCi, Terraform, Ansible, Consul & Co.]({{ site.url }}/images/2018/01/LogoArticlesPC_Terraform_Ansible_Consul_HAProxy.png)

Pour commencer à jouer un peu avec Consul, on va le faire tourner en local.

Mais aussi faire un premier tour d'horizon de ses paramètres.

<!--more-->

Déjà il faut le binaire à prendre sur le [Site de Consul](https://www.consul.io/downloads.html).

Ensuite, je t'ai préparé quelques fichiers tout prêts pour t'éviter de tout copier/coller. C'est disponible [ici](https://github.com/nledez/consul-screencast).

```
git clone https://github.com/nledez/consul-screencast.git
cd consul-screencast
```

J'ai aussi mis un script pour se souvenir comment lancer Consul :
```
$ cat launch_consul.sh
#!/bin/bash
consul agent -config-dir=$(pwd)/config.d -dev
```

Comme tu dois t'en douter, les fichiers de configuration vont aller dans `config.d` :
```
mkdir config.d
cp ex.consul/* config.d
```

Voici le contenu de chaque fichier :
```
==== config.d/bootstrap.json
{
    "bootstrap": true
}
==== config.d/server.json
{
    "server": true,
    "datacenter": "dc1",
    "data_dir": "`(mkdir data && cd data && pwd)`",
    "bind_addr": "127.0.0.1",
    "start_join": ["127.0.0.1"],
    "log_level": "INFO"
}
==== config.d/ui.json
{
    "ui": true
}
```

À la ligne `data_dir`, on va remplacer ce qu'il y a entre les guillemets par le résultat de la commande :
```
`(mkdir data && cd data && pwd)`
```

Le paramètre `bootstrap` est à positionner sur un (uniquement un) des serveurs dans le cluster. C'est pour simplifier les élections. Quand les élections n'arrivent pas à se faire (coucou les Belges), celui-là est le dictateur et s'élit de "force".

Il y a deux modes pour les services Consul :
 * Agent
 * Serveur

Comme on l'a vu plus haut le binaire est lancé avec l'instruction `agent`. Mais c'est le paramètre `server` qui va indiquer que cet agent est en mode serveur.

On pourrait se passer de `datacenter` qui de toute façon est par défaut à `dc1`. Mais au moins les choses sont explicites. Consul est prévu pour fonctionner sur plusieurs data-centres. Ce paramètre permet donc de savoir où est situé cet agent.

On peut aussi démarrer Consul avec le paramètre `-dev`. Dans ce cas toutes les informations seront stockées en mémoire. Donc à chaque redémarrage, on repart à 0.

Le paramètre `data_dir` permet de spécifier où Consul va persister ses informations. Que ce soit pour un serveur ou un agent. Il est impératif de pouvoir faire des lock sur ces fichiers. Il faut donc se méfier des filesystem un peu space type Virtualbox/NFS/... Il est parfaitement logique qu'il faille absolument mettre ce paramètre sur les membres du cluster pour ne pas perdre les données.

Pour spécifier sur quelle interface réseau Consul va communiquer, on va utiliser `bind_addr`. Par défaut Consul utilise `0.0.0.0`. Mais si plusieurs IPv4 sont présentes sur la machine Consul ne va pas démarrer. Ma machine et certains de mes serveurs ont plusieurs IPv4. Donc autant éviter les problèmes.

Il faut maintenant spécifier la liste des membres du cluster avec `start_join`. Ici on va mettre `127.0.0.1`. C'est juste pour jouer en local.

Si tu as trop ou pas suffisamment de logs dans ton terminal, tu peux jouer avec `log_level`.

Et pour finir le paramètre `ui` indique à Consul de servir l'UI sur le port HTTP.

Il nous reste qu'à démarrer :
```
bash ./launch_consul.sh
# Ou :
consul agent -config-dir=$(pwd)/config.d
# Ou encore :
consul agent -config-dir=$(pwd)/config.d -dev
```

Ça va te mettre dans la console des trucs du style :
```
bootstrap = true: do not enable unless necessary
==> Starting Consul agent...
==> Joining cluster...
    Join completed. Synced with 1 initial agents
==> Consul agent running!
           Version: 'v1.0.2'
           Node ID: 'e8b45893-f77f-09b2-3ce5-15397c3a39f6'
         Node name: 'jerry'
        Datacenter: 'dc1' (Segment: '<all>')
            Server: true (Bootstrap: true)
       Client Addr: [127.0.0.1] (HTTP: 8500, HTTPS: -1, DNS: 8600)
      Cluster Addr: 127.0.0.1 (LAN: 8301, WAN: 8302)
           Encrypt: Gossip: false, TLS-Outgoing: false, TLS-Incoming: false

==> Log data will now stream in as it occurs:

    2018/02/06 22:58:27 [INFO] raft: Initial configuration (index=1): [{Suffrage:Voter ID:e8b45893-f77f-09b2-3ce5-15397c3a39f6 Address:127.0.0.1:8300}]
[...]
```

En version commentée :
```
==> Starting Consul agent... -> Ben là ça démarre...
==> Joining cluster...
    Join completed. Synced with 1 initial agents -> On a joint le cluster. On est synchro avec un agent (c'est lui même)
==> Consul agent running! -> L'agent fonctionne
           Version: 'v1.0.2' -> En version 1.0.2
           Node ID: 'e8b45893-f77f-09b2-3ce5-15397c3a39f6' -> L'ID du noeud
         Node name: 'jerry' -> Son nom
        Datacenter: 'dc1' (Segment: '<all>') -> Il est dans le datacenter 'dc1' et tous les segments
            Server: true (Bootstrap: true) -> C'est un serveur. Et même le dictateur
       Client Addr: [127.0.0.1] (HTTP: 8500, HTTPS: -1, DNS: 8600) -> L'agent écoute sur 127.0.0.1
                                                                   -> l'HTTPS est désactivé par défaut
      Cluster Addr: 127.0.0.1 (LAN: 8301, WAN: 8302) -> Ça, c'est pour que les membres du cluster communiquent
           Encrypt: Gossip: false, TLS-Outgoing: false, TLS-Incoming: false
            -> On ne chiffre pas le protocole Gossip
            -> On ne chiffre ni ne vérifie avec TLS en entrée/sortie
```

On peut aussi vérifier la liste de tous les membres :
```
$ consul members
Node   Address         Status  Type    Build  Protocol  DC   Segment
jerry  127.0.0.1:8301  alive   server  1.0.2  2         dc1  <all>
```

Mais aussi récupérer toutes les informations :
```
consul info
agent:
	check_monitors = 0
	check_ttls = 0
	checks = 0
	services = 0
build:
	prerelease =
	revision = b55059f+
	version = 1.0.2
consul:
	bootstrap = true
	known_datacenters = 1
	leader = true
	leader_addr = 127.0.0.1:8300
	server = true
raft:
	applied_index = 181
	[...]
	state = Leader
	term = 2
runtime:
	arch = amd64
	[...]
	version = go1.9.2
serf_lan:
	coordinate_resets = 0
	encrypted = false
	[...]
	query_time = 1
serf_wan:
	coordinate_resets = 0
	encrypted = false
	[...]
	query_time = 1
```

Si tu te connectes sur [http://127.0.0.1:8500/ui/](http://127.0.0.1:8500/ui/) tu auras l'IHM de Consul :

![Consul UI liste des services]({{ site.url }}/images/2018/02/consul-01-services.png)
![Consul UI liste des noeuds]({{ site.url }}/images/2018/02/consul-02-nodes.png)
![Consul UI liste des clés/valeurs]({{ site.url }}/images/2018/02/consul-03-kv-empty.png)

On va maintenant jouer avec la base de donnée clé/valeur (KV) :
```
$ consul kv put dossier/
Success! Data written to: dossier/
$ consul kv put dossier/value 42
Success! Data written to: dossier/value
$ consul kv get dossier/value
42
```

Tu peux vérifier dans l'IHM à chaque étape. Voir si ça bouge. Ou même faire les manipulations dans l'UI.

![Consul UI avec des clés qui ont des valeurs]({{ site.url }}/images/2018/02/consul-04-with-value.png)

Et maintenant un petit peu de ménage :

```
$ consul kv delete dossier/value
Success! Deleted key: dossier/value
$ consul kv delete dossier/
Success! Deleted key: dossier/
```

Voilà, nous avons déjà vu pas mal de choses avec Consul.

La screencast qui correspond est disponible sur [Youtube](https://youtu.be/gbSQZf_x3DA).

N'hésitez pas à partager, poser des questions, faire des remarques.

À bientôt pour la suite.
