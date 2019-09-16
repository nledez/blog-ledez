---
date: 2019-09-16
title: Comment récupérer un 'rm -rf /var/lib/mysql/*'
author: Nicolas Ledez
layout: post
permalink: /comment-récupérer-un-rm-rf-var-lib-mysql/
categories:
  - Informatique
tags:
  - Informatique
  - sysadmin
  - Mysql
excerpt_separator: <!--more-->
---
![Mysql crash]({{ site.url }}/images/2019/09/MysqlCrash.jpg)

Il y a un dicton que j'aime bien :
> Dans la vie, il y a deux types d'administrateurs système :
> - Celui qui a déjà fait une grosse connerie en production
> - Et celui que ne va pas tarder

Et bien je viens de passer de la deuxième à la première catégorie en une ligne de commande :

{% highlight bash %}
cd /var/lib/mysql
rm -rf *
{% endhighlight %}

Et bien entendu sur le serveur de production, et pas sur la future prod.

Bref, la GROSSE boulette. Sur une BDD de 80Go qui prend plusieurs heures à restaurer.

Et bien gros spoiler, nous avons réussi à tout restaurer.

Avant de lire la suite, je ne garantis pas que cela va fonctionner chez vous. Et décline toute responsabilité si vous perdez vos données.

Mais vous serez peut-être content de pouvoir récupéré un maximum de vos bases/tables.

<!--more-->

Déjà, le premier truc à faire, c'est couper toute activité qu'il pourrait y avoir sur cette instance :
- Couper l'application
- Mettre une règle iptable

Peut importe, mais surtout réduire les accès à cette instance.

Le deuxième truc à avoir en tête, NE PAS ARRÊTER Mysql. C'est ce qui va nous sauver.

J'ai depuis écrit un script Python qui va permettre de sauvegarder un maximum de chose.

Ensuite, je vais rapidement expliquer pourquoi tout cela peut fonctionner.

Mais d'abord, voici comment reproduire ça chez vous (dans un Vagant). N'essayez pas ça sur un vrai serveur.

# Mise en place de l'environnement de test

On va utiliser [Vagrant](https://www.vagrantup.com)

```
git clone https://github.com/nledez/recover_deleted_mysql.git
cd recover_deleted_mysql
vagrant up
vagrant ssh
# À partir de là, nous sommes dans la VM Vagrant.
# Avant de faire des opérations dangereuses, assurez-vous de toujours y être...
# Le prompt doit être : vagrant@ubuntu-bionic

# On va charger des données dans Mysql
git clone https://github.com/datacharmer/test_db.git
cd test_db
cat employees.sql | sudo mysql

# On affiche la liste de bases pour vérifier que l'import à bien fonctionné
echo 'show databases;' | sudo mysql

# On va faire un backup pour plus tard (il en faut toujours un, et ça va permettre de redémarrer le test à partir de là)
sudo service mysql stop
sudo mkdir /backup
sudo rsync -av /var/lib/mysql/ /backup/
sudo chmod 777 /backup
sudo service mysql start
sudo bash /vagrant/read_all_data.sh
# La dernière commande permet de lister toutes les données de toutes les tables, ça permet de tout charger en mémoire.

# Il est temps de détruire la BDD (C'est surtout cette partie là à ne jamais faire en prod)
sudo find /var/lib/mysql -type f -exec rm {} \;
sudo find /var/lib/mysql -type d -exec rmdir {} \;
# Ouupppsss
sudo ls -la /var/lib/mysql/
# Et maintenant, on va vérifier que c'est bien la grosse merde en prod :
echo 'show databases;' | sudo mysql
```

# On va démarrer la restauration :

```
# On crée un répertoire dans lequel on va mettre les fichiers que l'on va récupérer (il faudra la place de l'ancien /var/lib/mysql)
sudo mkdir /recover
# On va récupérer le PID du process Mysql
ps ax | grep [m]ysqld
# On va le stocker dans une variable (c'est plus simple pour le reste de l'article)
MYSQL_PID=2530
# On va faire un `lsof` qui va nous montrer pourquoi on va pouvoir récupérer la catastrophe
sudo lsof -p $MYSQL_PID
```

## Et maintenant, laissons opérer la magie

### Le script en mode `--help`

```
$ sudo /vagrant/recover_deleted_mysql.py --help
usage: recover_deleted_mysql.py [-h] --pid PID [--recover_path RECOVER_PATH]
                                [--mysql_path MYSQL_PATH] [--touch_files]
                                [--export_as_csv EXPORT_AS_CSV [EXPORT_AS_CSV ...]]
                                [--csv_path CSV_PATH]

Mysql recuperator

optional arguments:
  -h, --help            show this help message and exit
  --pid PID             PID of Mysql process
  --recover_path RECOVER_PATH
                        Path of directory if you want revover deleted files
  --mysql_path MYSQL_PATH
                        Path of mysql directory if you want limit recovery
  --touch_files         If you want touch deleted files
  --export_as_csv EXPORT_AS_CSV [EXPORT_AS_CSV ...]
                        List of databases to export require --csv_path
                        argument
  --csv_path CSV_PATH   Path of csv export
```

### Récupération des fichiers supprimés

```
sudo /vagrant/recover_deleted_mysql.py --pid $MYSQL_PID --mysql_path /var/lib/mysql --recover_path /recover
# Et on peux vérifier avec la commande `sudo find /recover -ls`
```

### Extraction des données aux formats CSV pour plus de sécurité

Bon, si jamais la BDD est corrompue, on sera bien content d'avoir les données au format CSV.
Par contre, dans mes tests, j'ai eu beaucoup de crash du moteur Mysql, il faut donc être très prudent dans les commandes.
Mais aussi se dire que ça risque de planter et que l'on va tout perdre.

```
# Première étape, on va faire un touch des fichiers qui ont été supprimés (oui, ca parait débile, mais pourtant ça fonctionne)
sudo /vagrant/recover_deleted_mysql.py --pid $MYSQL_PID --mysql_path /var/lib/mysql --touch_files
# TRÈS important, changer les droits des répertoires et fichiers avant de faire quoi que ce soit (c'est là que Mysql peut planter)
sudo chown -R mysql:mysql /var/lib/mysql
# Maintenant, on peut lister les BDD
echo 'show databases;' | sudo mysql
# Mais on ne voit pas encore les tables
echo 'show tables;' | sudo mysql employees
# Il nous faut les fichiers .frm qui contiennent les structures des tables (il faut donc avoir un backup de ces fichiers sous la main)
cd /backup/
sudo find * -name '*.frm' -exec cp {} /var/lib/mysql/{} \;
sudo chown -R mysql:mysql /var/lib/mysql
echo 'show tables;' | sudo mysql employees
# Et maintenant, on peut faire des select dans les tables. Mais pas de mysqldump et surtout dans mes tests, ça a fait cracher Mysql :(
# NE PAS LANCER de mysqldump avant d'avoir terminé tout ça
# Dans une installation "normal", Mysql ne peut pas écrire de fichier n'importe où. On va aller chercher le chemin qui est configuré :
echo 'SHOW VARIABLES LIKE "secure_file_priv";' | sudo mysql # Get /var/lib/mysql-files/
# Et on lance l'export
sudo /vagrant/recover_deleted_mysql.py --pid $MYSQL_PID --csv_path /var/lib/mysql-files --export_as_csv employees
```

Et voilà !

### Remettre les données en place

```
# On copie les fichiers restaurés dans le répertoire Mysql :
sudo rsync -av /recover/var/lib/mysql/ /var/lib/mysql/
# On arrest Mysql
sudo service mysql stop
# On remet les bons droits
sudo chown -R mysql:mysql /var/lib/mysql
# On relance Mysql
sudo service mysql start
# On demande à Mysql de faire un check des bases
sudo mysqlcheck --all-databases
# On lance un `mysql_upgrade` qui remet toutes les bases/tables système en état de marche
sudo mysql_upgrade
# On relance Mysql
sudo service mysql restart
# On relance un Mysqldump pour être bien sûr que la BDD refonctionne bien
cd
sudo mysqldump employees > employees.sql
```

## Diverses instructions

- Ne jamais arrêter Mysql, jamais, jamais, jamais, jamais, jamais, jamais
- Ne pas essayer de mysqldump pendant que l'on utilise cet outil, jamais (encore une fois)
- On identifie le process mysql avec la commande `ps ax | grep [m]ysqld`
- On ne doit avoir qu'un seul process. Le noter pour plus tard
- On va vérifier les fichiers que l'on va pouvoir récupérer `sudo lsof -p $MYSQL_PID`
- On peut voir tous les fichiers '(deleted)'
- Et tant que l'on a Mysql qui est lancé, on va pouvoir récupérer ces fichiers

# Pourquoi ça peut fonctionner

Déjà, il faut comprendre comment fonctionne Linux en ext* au moment de la suppression d'un fichier.

On va revenir à la base. Quand un process ouvre un fichier, il ouvre un "file descriptor" FD dans `lsof`.

Un fichier, c'est défini dans le système de fichier ext* comme un chemin qui pointe vers un inode.

Quand on supprime un fichier, on supprime ce lien dans la table d'allocation des fichiers.

Et ext* libère la place quand un inode n'a plus de FD ouvert sur l'inode.

C'est pour ça que des fois, on supprime un gros fichier, mais que la place n'est pas libérée.

Ou encore quand on fait un `mv` d'un fichier de log, un touch du nouveau fichier et que le process continue à écrire dans le fichier qui a été renommé. Le FD est toujours ouvert sur l'ancien inode. Ça fait un peu mal à la tête hein ?

Et donc comme Mysql garde les fichiers ouverts, on peut faire un `cat /proc/$PID/df/9`

Voilà pour la partie récupération des fichiers supprimés.

Maintenant, les histoires de `touch`.

C'est la partie que je maîtrise moins, mais j'imagine le comportement de Mysql.

Quand on fait un `show databases;` Mysql doit lire la liste des répertoires dans `/var/lib/mysql`. C'est pour ça que l'on peut se retrouver avec une base de donnés `lost+found`.

Ensuite quand on fait un `show tables;` Mysql doit lire la liste des fichiers `*.MYI` ou `*.MYD` (ou les deux, ou quand l'un manque ça doit planter). Donc un touch des fichiers fait apparaître les tables. Mais comme les fichiers sont déjà ouverts, il va pouvoir accéder aux anciens fichiers supprimés.

Par contre un `desc table` ou un `select` ne va pas fonctionner. Pour cela Mysql a besoin des fichiers `*.frm` qui contiennent la structure des tables. Et là, il faut que les fichiers `frm/MYD/MYI` soient bien alignés.

Voilà, il ne nous reste que le Mysqldump qui ne fonctionne pas. Je pense qu'il essaye de lire directement dans le contenu des fichiers et que la bidouille avec les `touch` le perturbe.

J'en ai fini pour cet article. J'espère vous avoir appris des trucs. Que vous n'aurez jamais besoin de mettre tout ça en pratique sur de la prod.

Et si j'ai des conseils à donner :
- Faire des backup
- Tester les restaurations
- Noter le temps de ces opérations pour avoir conscience du temps que cela va prendre en cas de crash
- Si vous faites des mysqldump, pensez à aussi faire des sauvegardes des .frm régulièrement
