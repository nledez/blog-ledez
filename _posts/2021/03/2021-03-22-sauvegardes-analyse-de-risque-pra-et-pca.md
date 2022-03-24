---
date: 2021-03-22
title: Sauvegardes, analyse de risque, PRA et PCA
lang: fr
layout: post
permalink: /sauvegardes-analyse-de-risque-pra-et-pca/
categories:
  - Informatique
  - Securite
tags:
  - Informatique
  - securite
excerpt_separator: <!--more-->
---

![Sauvegardes, analyse de risque]({{ site.url }}/images/2021/03/backup-burning.jpg)

Bon, je ne vais pas revenir sur l'incident d'OVH :
{% twitter https://twitter.com/ovh_support_fr/status/1369602998633172994 %}

Mais ça fait un moment qu’un petit article sur l’analyse de risque me trotte dans la tête. Et visiblement, c’est le bon timing pour éviter d’être à nouveau dans la panade.

Disclamer: Les cordonniers sont les plus mal chaussés. [Et personne n'est à l'abri d'une erreur]({{ site.baseurl }}/informatique/comment-récupérer-un-rm-rf-var-lib-mysql/)
Et je ne suis pas un "spécialiste" en sécurité, dans le sens ou ce n'est pas mon activité principale (audit, flux, etc.). Mais j'ai fait une spécialisation dans mes études ce qui m'a donné des bases. Et j'ai toujours appliqué ces préceptes dans ma vie pro/perso.

<!--more-->

Bon, alors déjà c'est quoi un risque ? Sur Wikipedia, on peut lire deux pages :
[Risque](https://fr.wikipedia.org/wiki/Risque#Dans_l'informatique) et [Sécurité des systèmes d'information](https://fr.wikipedia.org/wiki/S%C3%A9curit%C3%A9_des_syst%C3%A8mes_d%27information)

Ce que l'on peut retenir, c'est la définition :
"Le risque est la possibilité de survenue d'un événement indésirable, la probabilité d’occurrence d'un péril probable ou d'un aléa"

Et une formule mathématique que je vais simplifier :
r = p⋅C

En bon français, le risque est égal à la probabilité multipliée par la conséquence (financière par exemple).

Ensuite, une fois que l'on a évalué ce risque, on va choisir de le prendre en compte ou pas. Et donc le traiter si besoin.

Bon, c'est bien gentil tout ça, mais j'en fais quoi ? On va prendre quelques cas simples que j'ai rencontrés dans ma vie de sysadmin (le vieux nom de devops/sre/...).

# Cas numéro 1 - un serveur dédié chez OVH

## L'analyse de risque

Légende :
- Mon app est plus ou moins injoignable -> +/-
- Mon app est totalement injoignable -> ☠️

| Risques                                                | probabilité | conséquence  |
|--------------------------------------------------------|-------------|--------------|
| Je fais un `rm -rf` dans mes fichiers                  | Haute       | +/-          |
| Je fais un `DELETE from ITEMS` dans ma base de données | Haute       | +/-          |
| Je me fais pirater (remplacement des fichiers)         | Moyenne     | ☠️            |
| Un composant de ma machine tombe en panne              | Moyenne     | ☠️            |
| Le disque dur tombe en panne                           | Moyenne     | ☠️            |
| Ma machine ne redémarre pas                            | Moyenne     | ☠️            |
| La machine brûle / l'hébergeur devient injoignable     | Faible      | ☠️            |
| Le continent où est hébergé le serveur disparaît       | Très faible | ☠️            |

Bon, on peut aussi chercher à estimer les coûts, mais globalement on ne veut ni perdre de donnée ni que l'application soit indisponible.

## Les contre-mesures

### Je fais un `rm -rf` dans mes fichiers

Là, c'est le problème à la fois le plus simple et le plus compliqué dont se protéger. Simple parce qu'un bête `rsync` peut suffire à réduire le risque. Et compliqué parce que l'on peut vouloir gérer un "historique", mais aussi s'il y a trop de fichiers/volumétrie.

Bon, déjà pour gagner du temps pour plus tard, si vous en avez la possibilité, passez directement sur de l'object-storage. Vous allez anticiper pas mal de problèmes pour le futur :
- Passer sur plusieurs machines
- Passer sur des vm "cloud" dont le disque est "volatile"
- Plusieurs To de fichiers à sauvegarder
- Plusieurs millions de fichiers à sauvegarder
- Temps de restauration quand on a plusieurs To

Sinon, ce que je mets souvent en place, c'est :
- rsync sur un serveur de sauvegarde distant (on va y revenir plus tard)
- des snapshoots sur mon serveur de sauvegarde (j'utilise ZFS maintenant)
- des snapshoots sur x jours / x semaines / x mois

Si des fichiers sont supprimés, je fais un `rsync` dans l'autre sens. À partir d'un snapshoot au besoin.


### Je fais un `DELETE from ITEMS` dans ma base de données

Dans ce cas, je fais tous les jours des sauvegardes locales soit :
- mysqldump/pg_dump
- quand la base est trop grosse à exporter, backup à chaud/froid style percona backup. Une complète par semaine, puis une incrémentale par jour

Ensuite, tout ça est copié via `rsync` sur le serveur de backup + un snapshoot.

Si j'ai besoin de restaurer, j'importe le fichier qui est local, ou je copie du serveur distant. Si c'est un peu plus "chigurgical", le développeur a accès à une base sur laquelle il peut extraire les données dont il a besoin.


### Je me fais pirater (remplacement des fichiers)

Vous savez, vous vous connectez sur votre site, et vous avez une revendication politique ; un truc du style hacktiviste.

Là, c'est très simple, on restaure les fichiers. Ensuite on cherche d'où vient la faille pour la corriger. Ou l'inverse si on a le temps.

Pensez à regarder si personne n'est connecté, sauvegardez/regardez les logs, etc. Dans l'idéal, une fois le problème corrigé, réinstallez complètement l'OS de zéro pour écarter tout risque de compromission résiduelle.


### Un composant de la machine tombe en panne

Là aussi c'est très simple. Ça arrive que la carte mère crame, le CPU, la RAM, etc. Le serveur ne répond plus ou perd les pédales. Une fois, j'ai eu un load average énorme au moindre curl. C'était la carte mère qui avait pris un jeton... Nous y avions passé la semaine à essayer de comprendre la source du problème...

Bref un ticket à OVH, on éteint le serveur, on change la pièce, et c'est reparti pour un tour :)

Bon, c'est clair que pendant ce temps là, l'application est indisponible. Mais tout le monde n'est pas prêt à payer pour du HA.

Et franchement en 15 ans d'hébergement, je n'ai pas eu tant que ça de problèmes...


### Le disque dur tombe en panne

Encore un problème simple à résoudre. On prend du RAID, on configure ça en RAID 1, 5, 6, JBOD,... tout ce que vous voulez. Mais JAMAIS du 0 sauf si vous voulez tout perdre :p

Un disque crame => ticket à OVH pour le changer.

Bien sûr, pensez à monitorer l'état du RAID. Ce serait con que le deuxième disque lâche avant le remplacement du premier. Oui, j'ai déjà vu ça...


### Ma machine ne redémarre pas

Alors là, c'est le truc très con. Upgrade du noyau, reboot, et on attend......

Donc, prenez des serveurs avec un KVM (console Keyboard Video Mouse - pas d'intérêt d'avoir la souris pour nous, mais c'est le nom). Et connectez-vous AVANT de rebooter. Et pas juste une connexion au KVM, connectez-vous avec le compte login/pass. Un autre conseil au passage, désactivez la connexion SSH du root. Mais autorisez la connexion en console. Vous me remercierez en cas de galère. Et pensez au mapping du clavier que vous allez utiliser. Je suis passé en full QWERTY depuis 10 ans, ça m'évite pas mal de problèmes de ce côté-là. Et dans vos choix de pass, pensez à ceux qui ont de l'AZERTY/BEPO/.... Ils pourraient pleurer en tapant `iWzyodO[OZ+CS}g|Y',]|Z2'b<(7/2Ez3kn` :p Et vous aussi, donc privilégiez un truc du type `lakeside-emporium-indulge-ARGOT`, ce sera plus simple à taper dans l'urgence.


### La machine brûle / l'hébergeur devient injoignable

Bon, clairement un serveur qui brûle c'est rare. Un DC entier, c'est encore plus rare. Mais on a vu que c'était possible. Et quand j'expliquais ça il y a quelques années, les gens/collègues me regardaient en rigolant en me traitant de parano :D

Encore une fois, la probabilité que ça arrive est très faible. Mais le jour où ça arrive, vous n'avez plus rien. Donc pour se préparer à ça, il faut pouvoir :
- Réinstaller l'OS
- Réinstaller les applicatifs
- Réinstaller les données

Et comme votre serveur n'est plus là, aucune chance de savoir comment c'était configuré avant...

Donc :
- Gestionnaire de configuration => Saltstack/Ansible/Chef/Script shell/au pire de la doc
- Passez régulièrement votre gestionnaire de configuration
- Rien à la main, ou alors documenté, si possible au même endroit que le gestionnaire de configuration
- Bien sûr, sauvegardez ça aussi...
- Faire des snapshoot des VM, ça permet de relancer le service plus vite sur un autre site, voir un autre hébergeur si l'hyperviseur est installable ailleurs
- Et on teste de temps en temps
- Mais surtout à chaque changement majeur ! (version d'OS / d'hyperviseur)

### Le continent où est hébergé le serveur disparaît

Bon, l'Europe est engloutie sous les mers telle l'Atlantide, on se fait atomiser par un météorite comme nos ancêtres les dinosaures. Là, je dois vous avouer que je n'ai pas adressé ce problème. Mais comme je serais mort....


## Pour résumer

Toutes les semaines :
- Snapshoot des vm
- Backup full de ma BDD
- Transfert de tout ça sur le serveur de sauvegarde distant

Tous les jours :
- Backup de la BDD
- Rsync des fichiers
- Rsync des sauvegardes de BDD


## Le serveur de sauvegarde

J'en parle, mais quoi et où ?

Pour réduire les risques :
- Chez un autre fournisseur
- Un minimum de kilomètres entre les DC (on parle souvent de 300km), accident nucléaire, météorite, tremblement de terre ...
- C'est le serveur qui va chercher les sauvegardes (pull). Si le serveur de prod est compromis, il ne faut pas que l'attaquant puisse se connecter à ce serveur
- Filtrez les IP qui peuvent se connecter
- Et toute protection pour blinder ce serveur est bonne à mettre en place


## Et ça suffit ?

Ça dépend de votre niveau de parano. Un backup sur votre NAS c'est bien aussi. Mais dans ce cas là, pensez à le chiffrer.


## Et pourquoi ne pas mettre tout ça chez moi ?

C'est sûr qu'avec la fibre optique vous avez de plus en plus la possibilité de vous héberger. Sauf que :
- Rentrer dans un DC est de plus en plus dur
- Un DC qui brûle, c'est plutôt rare
- Une coupure de fibre, ça arrive. Un DC a plusieurs arrivées, et des SLA garanties par les opérateurs, les techniciens vont donc ressouder les fibres très vite

Et chez vous ? Personnellement, je n'ai plus rien de critique chez moi. Au pire, je me fais voler/détruire ma workstation et sa sauvegarde.

Et quand je parle d'intrusion, il y a le vol qui inclut la perte des données. Mais que se passerait-il si les données fuitaient par la suite ? GDPR et/ou concurrents ?

# Et maintenant ?

Je pense que l'article est déjà suffisamment long. Mais je pense que vous avez l'idée. Avec tout ça, nous avons un Plan de Reprise d’Activité.

Depuis que je mets tout ça en place, je dors beaucoup mieux. Je ne dis pas que je serais parfaitement serein si GRA/RBX brûlait, j'ai beaucoup plus de serveurs là-bas.

Mais globalement, je pense avoir adressé pas mal de problèmes.

Et à chaque nouvelle technologie, il faut se renouveler et recommencer cette analyse de risque.

Comment je gère mes vm "cloud", comment je sauvegarde mon object storage ?

Nous n’avons pas non plus discuté du coût de ces contre-mesures, dans ce cas là, ce n’est pas vraiment négociable de faire sans. Par contre, nous n’avons pas parlé de Plan de Continuité d’Activité.

En gros tout est déjà prêt au cas où le site principal est HS. Voir, ça bascule tout seul, mais ça, c’est une autre histoire et ne coûte PAS DU TOUT la même chose qu’un PRA…

Et toi ? Tu gères tout ça comment ?


Crédit des images :
[Cartouche de sauvegarde](https://en.wikipedia.org/wiki/Linear_Tape-Open#/media/File:LTO2-cart-purple.jpg)
[DC](https://commons.wikimedia.org/wiki/Category:Data_centers#/media/File:CERN_Server_03.jpg)
[Feu](https://en.wikipedia.org/wiki/Fire_ecology#/media/File:2011-08-04_20_00_00_Susie_Fire_in_the_Adobe_Range_west_of_Elko_Nevada.jpg)
