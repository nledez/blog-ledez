---
id: 410
title: Vagrant ou les VM pour les nuls
author: Nicolas Ledez
layout: post
guid: http://blog.ledez.net/?p=410
permalink: /informatique/vagrant-ou-les-vm-pour-les-nuls/
categories:
  - Informatique
tags:
  - vagran
  - virtualisation
  - vm
excerpt_separator: <!--more-->
---
<img class="size-medium wp-image-411 alignright" title="Vagrant" src="http://blog.ledez.net/wp-content/uploads/2012/02/vagrant_chilling-300x300.png" alt="" width="300" height="300" srcset="http://blog.ledez.net/wp-content/uploads/2012/02/vagrant_chilling-150x150.png 150w, http://blog.ledez.net/wp-content/uploads/2012/02/vagrant_chilling-300x300.png 300w, http://blog.ledez.net/wp-content/uploads/2012/02/vagrant_chilling.png 350w" sizes="(max-width: 300px) 100vw, 300px" />

Pour un administrateur système, la virtualisation est un super jouet.

Et pour un développeur cela peut devenir un super outil, mais tellement compliqué à mettre en place.

Et c&rsquo;est là que Vagrant arrive à la rescousse :

  * Pas d&rsquo;installation d&rsquo;OS
  * Pas de réseau à gérer
  * Partage de fichier simplifié

Bref, c&rsquo;est dégoutant de simplicité pour un administrateur système.

Mais (il en faut bien un), la prise en main n&rsquo;est pas forcement très simple&#8230;

<!--more-->

### Les termes à comprendre

  * Box
  * Package

Box : en gros, c&rsquo;est simplement un modèle décompressé de VM. Vagrant va s&rsquo;en servir pour déployer des VM.

Package : c&rsquo;est la version compressée d&rsquo;un modèle de VM.

On télécharge un package pour l&rsquo;installer en tant que box. Une instance de VM peut être convertie en package.

[<img class="alignnone size-medium wp-image-419" title="Workflow Vagrant" src="http://blog.ledez.net/wp-content/uploads/2012/02/vagrant-300x186.png" alt="" width="300" height="186" srcset="http://blog.ledez.net/wp-content/uploads/2012/02/vagrant-300x186.png 300w, http://blog.ledez.net/wp-content/uploads/2012/02/vagrant.png 741w" sizes="(max-width: 300px) 100vw, 300px" />][1]

### Installation de VirtualBox

<img class="size-full wp-image-416 alignright" title="Virtual Box" src="http://blog.ledez.net/wp-content/uploads/2012/02/vbox_logo2_gradient.png" alt="" width="140" height="180" />

La première chose à faire est d&rsquo;installer Virtual Box : direction [le site de Virtual Box][2]. Prenez l&rsquo;installeur qui correspond à votre système d&rsquo;exploitation. Attention Vagrant ne supporte que les versions VirtualBox 4.0.x et 4.1.x. Il y a peut-être une solution pour votre distribution Linux du style package tout prêt. Et je ne sais absolument pas ce que ça donne sous Windows.

### Installation de Vagrant

{% highlight bash %}
$ rvm use 1.9.3@vagrant --create
$ gem install vagrant
{% endhighlight %}

### Installation d&rsquo;une VM par défaut

Pour la première VM on va utiliser un package d&rsquo;Internet.

{% highlight bash %}
$ vagrant box add lucid64 http://files.vagrantup.com/lucid64.box
{% endhighlight %}

### Première VM

{% highlight bash %}
$ vagrant init
A `Vagrantfile` has been placed in this directory. You are now
ready to `vagrant up` your first virtual environment! Please read
the comments in the Vagrantfile as well as documentation on
`vagrantup.com` for more information on using Vagrant.
{% endhighlight %}

Vous pouvez simplifier le fichier Vagrantfile :

{% highlight ruby %}
Vagrant::Config.run do |config|
  config.vm.box = "base"
  # config.vm.boot_mode = :gui
end
{% endhighlight %}

Pensez à remplacer la ligne :

{% highlight ruby %}
config.vm.box = "base"
{% endhighlight %}

Par notre box installé tout à l&rsquo;heure :

{% highlight ruby %}
config.vm.box = "lucid64"
{% endhighlight %}

Et maintenant lancer la création de la VM. Attention c&rsquo;est magique <img src="https://blog.ledez.net/wp-includes/images/smilies/simple-smile.png" alt=":)" class="wp-smiley" style="height: 1em; max-height: 1em;" /> :

{% highlight bash %}
$ vagrant up
[default] Importing base box 'lucid64'...
[default] Progress: 60%
[default] Matching MAC address for NAT networking...
[default] Clearing any previously set forwarded ports...
[default] Fixed port collision for 22 => 2222. Now on port 2200.
[default] Forwarding ports...
[default] -- 22 => 2200 (adapter 1)
[default] Creating shared folders metadata...
[default] Clearing any previously set network interfaces...
[default] Booting VM...
[default] Waiting for VM to boot. This can take a few minutes.
[default] VM booted and ready for use!
[default] Mounting shared folders...
[default] -- v-root: /vagrant
{% endhighlight %}

Notre machine est prête :

{% highlight bash %}
$ vagrant ssh
Linux lucid64 2.6.32-33-server #70-Ubuntu SMP Thu Jul 7 22:28:30 UTC 2011 x86_64 GNU/Linux
Ubuntu 10.04.3 LTS

vagrant@lucid64:~$
{% endhighlight %}

Et voilà !

Pour arrêter notre VM, on sort du SSH et :

{% highlight bash %}
$ vagrant halt
[default] Attempting graceful shutdown of VM...
{% endhighlight %}

### Mettre à jour une box

Quand j&rsquo;ai essayé Vagrant hier, je suis tombé sur cette erreur :

{% highlight bash %}
[default] The guest additions on this VM do not match the install version of
VirtualBox! This may cause things such as forwarded ports, shared
folders, and more to not work properly. If any of those things fail on
this machine, please update the guest additions and repackage the
box.

Guest Additions Version: 4.1.0
VirtualBox Version: 4.1.8
{% endhighlight %}

J&rsquo;ai trouvé pas mal de solutions, mais trop compliqué et/ou qui télécharges les MAJ sur Internet. Moi je fais comme ça :  
Un petit backup :

{% highlight bash %}
$ tar cvzf ~/.vagrant.d/backup/lucid64.tgz ~/.vagrant.d/boxes/lucid64                                                 !7295
tar: Removing leading '/' from member names
a ~/.vagrant.d/boxes/lucid64
a ~/.vagrant.d/boxes/lucid64/box-disk1.vmdk
a ~/.vagrant.d/boxes/lucid64/box.mf
a ~/.vagrant.d/boxes/lucid64/box.ovf
a ~/.vagrant.d/boxes/lucid64/Vagrantfile
{% endhighlight %}

Dé-commenter la ligne suivante dans le fichier Vagrantfile :

{% highlight ruby %}
config.vm.boot_mode = :gui
{% endhighlight %}

{% highlight bash %}
$ vagrant destroy
$ vagrant up
$ vagrant ssh
{% endhighlight %}

La fenêtre de la VM va s&rsquo;ouvrir en parallèle. Sélectionner cette fenêtre et dans le menu &laquo;&nbsp;Périphérique / installer les additions invitées&nbsp;&raquo;

Donc maintenant nous sommes dans la VM :

{% highlight bash %}
vagrant@lucid64:~$ sudo mount /dev/sr0 /mnt
mount: block device /dev/sr0 is write-protected, mounting read-only
vagrant@lucid64:~$ sudo /mnt/VBoxLinuxAdditions.run
Verifying archive integrity... All good.
Uncompressing VirtualBox 4.1.8 Guest Additions for Linux..........
VirtualBox Guest Additions installer
Removing installed version 4.1.0 of VirtualBox Guest Additions...
tar: Record size = 8 blocks
Removing existing VirtualBox DKMS kernel modules ...done.
Removing existing VirtualBox non-DKMS kernel modules ...done.
Building the VirtualBox Guest Additions kernel modules
The headers for the current running kernel were not found. If the following
module compilation fails then this could be the reason.

Building the main Guest Additions module ...fail!
(Look at /var/log/vboxadd-install.log to find out what went wrong)
Doing non-kernel setup of the Guest Additions ...done.
Installing the Window System drivers ...fail!
(Could not find the X.Org or XFree86 Window System.)
{% endhighlight %}

Un petit tour dans le fichier /var/log/vboxadd-install.log nous dis qu&rsquo;il manque les headers du noyau. Pour les installer :

{% highlight bash %}
vagrant@lucid64:~$ sudo apt-get install linux-headers-$(uname -r) -y
Reading package lists... Done
Building dependency tree
Reading state information... Done
The following extra packages will be installed:
  linux-headers-2.6.32-33
The following NEW packages will be installed:
  linux-headers-2.6.32-33 linux-headers-2.6.32-33-server
0 upgraded, 2 newly installed, 0 to remove and 5 not upgraded.
Need to get 10.7MB of archives.
After this operation, 85.5MB of additional disk space will be used.
Get:1 http://us.archive.ubuntu.com/ubuntu/ lucid-updates/main linux-headers-2.6.32-33 2.6.32-33.70 [9924kB]
Get:2 http://us.archive.ubuntu.com/ubuntu/ lucid-updates/main linux-headers-2.6.32-33-server 2.6.32-33.70 [800kB]
Fetched 10.7MB in 41s (255kB/s)
Selecting previously deselected package linux-headers-2.6.32-33.
(Reading database ... 26603 files and directories currently installed.)
Unpacking linux-headers-2.6.32-33 (from .../linux-headers-2.6.32-33_2.6.32-33.70_all.deb) ...
Selecting previously deselected package linux-headers-2.6.32-33-server.
Unpacking linux-headers-2.6.32-33-server (from .../linux-headers-2.6.32-33-server_2.6.32-33.70_amd64.deb) ...
Setting up linux-headers-2.6.32-33 (2.6.32-33.70) ...
Setting up linux-headers-2.6.32-33-server (2.6.32-33.70) ...

vagrant@lucid64:~$ sudo /etc/init.d/vboxadd
Usage: /etc/init.d/vboxadd {start|stop|restart|status|setup}
vagrant@lucid64:~$ sudo /etc/init.d/vboxadd setup
Removing existing VirtualBox DKMS kernel modules ...done.
Removing existing VirtualBox non-DKMS kernel modules ...done.
Building the VirtualBox Guest Additions kernel modules
Building the main Guest Additions module ...done.
Building the shared folder support module ...done.
Building the OpenGL support module ...done.
Doing non-kernel setup of the Guest Additions ...done.
You should restart your guest to make sure the new modules are actually used
{% endhighlight %}

Un petit reboot pour vérifier que ça fonctionne :

{% highlight bash %}
$ vagrant halt
[default] Attempting graceful shutdown of VM...
$ vagrant up
[default] VM already created. Booting if it's not already running...
[default] Clearing any previously set forwarded ports...
[default] Forwarding ports...
[default] -- 22 => 2222 (adapter 1)
[default] Creating shared folders metadata...
[default] Clearing any previously set network interfaces...
[default] Booting VM...
[default] Waiting for VM to boot. This can take a few minutes.
[default] VM booted and ready for use!
[default] Mounting shared folders...
[default] -- v-root: /vagrant
{% endhighlight %}

Maintenant, transformer la VM en package :

{% highlight bash %}
$ vagrant package
[default] Attempting graceful shutdown of VM...
[default] Clearing any previously set forwarded ports...
[default] Creating temporary directory for export...
[default] Exporting VM...
[default] Compressing package to: ~/Vagrant/template/package.box
{% endhighlight %}

Et installer le nouveau package pour remplacer la box :

{% highlight bash %}
$ vagrant box remove lucid64
[vagrant] Deleting box 'lucid64'...

$ vagrant box add lucid64 package.box
[vagrant] Downloading with Vagrant::Downloaders::File...
[vagrant] Copying box to temporary location...
[vagrant] Extracting box...
[vagrant] Verifying box...
[vagrant] Cleaning up downloaded box...
{% endhighlight %}

Maintenant, re-commenter la ligne suivante dans le fichier Vagrantfile :

{% highlight ruby %}
config.vm.boot_mode = :gui
{% endhighlight %}

Pour essayer si la nouvelle box fonctionne :

{% highlight bash %}
$ vagrant destroy
[default] Destroying VM and associated drives...

$ vagrant up
[default] Importing base box 'lucid64'...
[default] Matching MAC address for NAT networking...
[default] Clearing any previously set forwarded ports...
[default] Forwarding ports...
[default] -- 22 => 2222 (adapter 1)
[default] Creating shared folders metadata...
[default] Clearing any previously set network interfaces...
[default] Booting VM...
[default] Waiting for VM to boot. This can take a few minutes.
[default] VM booted and ready for use!
[default] Mounting shared folders...
[default] -- v-root: /vagrant
{% endhighlight %}

Si vous avez compris comment mettre à jours la box, immaginez vous faire la même chose avec l&rsquo;installation de middleware (Apache, Nginx, PHP, Rails, &#8230;) <img src="https://blog.ledez.net/wp-includes/images/smilies/simple-smile.png" alt=":)" class="wp-smiley" style="height: 1em; max-height: 1em;" />

Prochain épisode ? Déploiment d&rsquo;un environnement pour héberger du Rails ?

Vous pouvez demander si vous avez d&rsquo;autres idées d&rsquo;articles.

Edit:  
Je me suis posé la question d’où est-ce que je pouvais trouver des boxes toutes prêtes. Parce que bon, Ubuntu 64bits c&rsquo;est bien. Mais moi j&rsquo;ai aussi de la Debian <img src="https://blog.ledez.net/wp-includes/images/smilies/simple-smile.png" alt=":)" class="wp-smiley" style="height: 1em; max-height: 1em;" />  
J&rsquo;ai trouvé http://vagrantbox.es/ et je me suis rendu compte après que [@Ethernitys][3] l&rsquo;avait ajouté dans un Tweet qui concernait cet article.

 [1]: http://blog.ledez.net/wp-content/uploads/2012/02/vagrant.png
 [2]: https://www.virtualbox.org/wiki/Downloads "Le téléchargement de Virtual Box"
 [3]: http://twitter.com/#!/Ethernitys "@Ethernitys"
