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

<div class="codecolorer-container bash default" style="overflow:auto;white-space:nowrap;">
  <div class="bash codecolorer">
    $ rvm use 1.9.3<span class="sy0">@</span>vagrant <span class="re5">--create</span><br /> $ gem <span class="kw2">install</span> vagrant
  </div>
</div>

### Installation d&rsquo;une VM par défaut

Pour la première VM on va utiliser un package d&rsquo;Internet.

<div class="codecolorer-container bash default" style="overflow:auto;white-space:nowrap;">
  <div class="bash codecolorer">
    <span class="co4">$ </span>vagrant box add lucid64 http:<span class="sy0">//</span>files.vagrantup.com<span class="sy0">/</span>lucid64.box
  </div>
</div>

### Première VM

<div class="codecolorer-container bash default" style="overflow:auto;white-space:nowrap;">
  <div class="bash codecolorer">
    $ vagrant init<br /> A <span class="sy0">`</span>Vagrantfile<span class="sy0">`</span> has been placed <span class="kw1">in</span> this directory. You are now<br /> ready to <span class="sy0">`</span>vagrant up<span class="sy0">`</span> your first virtual environment<span class="sy0">!</span> Please <span class="kw2">read</span><br /> the comments <span class="kw1">in</span> the Vagrantfile <span class="kw2">as</span> well <span class="kw2">as</span> documentation on<br /> <span class="sy0">`</span>vagrantup.com<span class="sy0">`</span> <span class="kw1">for</span> <span class="kw2">more</span> information on using Vagrant.
  </div>
</div>

Vous pouvez simplifier le fichier Vagrantfile :

<div class="codecolorer-container ruby default" style="overflow:auto;white-space:nowrap;">
  <div class="ruby codecolorer">
    <span class="re2">Vagrant::Config</span>.<span class="me1">run</span> <span class="kw1">do</span> <span class="sy0">|</span>config<span class="sy0">|</span><br /> &nbsp; config.<span class="me1">vm</span>.<span class="me1">box</span> = <span class="st0">"base"</span><br /> &nbsp; <span class="co1"># config.vm.boot_mode = :gui</span><br /> <span class="kw1">end</span>
  </div>
</div>

Pensez à remplacer la ligne :

<div class="codecolorer-container ruby default" style="overflow:auto;white-space:nowrap;">
  <div class="ruby codecolorer">
    config.<span class="me1">vm</span>.<span class="me1">box</span> = <span class="st0">"base"</span>
  </div>
</div>

Par notre box installé tout à l&rsquo;heure :

<div class="codecolorer-container ruby default" style="overflow:auto;white-space:nowrap;">
  <div class="ruby codecolorer">
    config.<span class="me1">vm</span>.<span class="me1">box</span> = <span class="st0">"lucid64"</span>
  </div>
</div>

Et maintenant lancer la création de la VM. Attention c&rsquo;est magique <img src="https://blog.ledez.net/wp-includes/images/smilies/simple-smile.png" alt=":)" class="wp-smiley" style="height: 1em; max-height: 1em;" /> :

<div class="codecolorer-container bash default" style="overflow:auto;white-space:nowrap;">
  <div class="bash codecolorer">
    $ vagrant up<br /> <span class="br0">&#91;</span>default<span class="br0">&#93;</span> Importing base box <span class="st_h">'lucid64'</span>...<br /> <span class="br0">&#91;</span>default<span class="br0">&#93;</span> Progress: <span class="nu0">60</span><span class="sy0">%</span><br /> <span class="br0">&#91;</span>default<span class="br0">&#93;</span> Matching MAC address <span class="kw1">for</span> NAT networking...<br /> <span class="br0">&#91;</span>default<span class="br0">&#93;</span> Clearing any previously <span class="kw1">set</span> forwarded ports...<br /> <span class="br0">&#91;</span>default<span class="br0">&#93;</span> Fixed port collision <span class="kw1">for</span> <span class="nu0">22</span> =<span class="sy0">></span> <span class="nu0">2222</span>. Now on port <span class="nu0">2200</span>.<br /> <span class="br0">&#91;</span>default<span class="br0">&#93;</span> Forwarding ports...<br /> <span class="br0">&#91;</span>default<span class="br0">&#93;</span> <span class="re5">--</span> <span class="nu0">22</span> =<span class="sy0">></span> <span class="nu0">2200</span> <span class="br0">&#40;</span>adapter <span class="nu0">1</span><span class="br0">&#41;</span><br /> <span class="br0">&#91;</span>default<span class="br0">&#93;</span> Creating shared folders metadata...<br /> <span class="br0">&#91;</span>default<span class="br0">&#93;</span> Clearing any previously <span class="kw1">set</span> network interfaces...<br /> <span class="br0">&#91;</span>default<span class="br0">&#93;</span> Booting VM...<br /> <span class="br0">&#91;</span>default<span class="br0">&#93;</span> Waiting <span class="kw1">for</span> VM to boot. This can take a few minutes.<br /> <span class="br0">&#91;</span>default<span class="br0">&#93;</span> VM booted and ready <span class="kw1">for</span> use<span class="sy0">!</span><br /> <span class="br0">&#91;</span>default<span class="br0">&#93;</span> Mounting shared folders...<br /> <span class="br0">&#91;</span>default<span class="br0">&#93;</span> <span class="re5">--</span> v-root: <span class="sy0">/</span>vagrant
  </div>
</div>

Notre machine est prête :

<div class="codecolorer-container bash default" style="overflow:auto;white-space:nowrap;">
  <div class="bash codecolorer">
    $ vagrant <span class="kw2">ssh</span><br /> Linux lucid64 2.6.32-<span class="nu0">33</span>-server <span class="co0">#70-Ubuntu SMP Thu Jul 7 22:28:30 UTC 2011 x86_64 GNU/Linux</span><br /> Ubuntu 10.04.3 LTS<br /> <br /> <span class="co4">vagrant@lucid64:~$</span>
  </div>
</div>

Et voilà !

Pour arrêter notre VM, on sort du SSH et :

<div class="codecolorer-container bash default" style="overflow:auto;white-space:nowrap;">
  <div class="bash codecolorer">
    $ vagrant halt<br /> <span class="br0">&#91;</span>default<span class="br0">&#93;</span> Attempting graceful shutdown of VM...
  </div>
</div>

### Mettre à jour une box

Quand j&rsquo;ai essayé Vagrant hier, je suis tombé sur cette erreur :

<div class="codecolorer-container bash default" style="overflow:auto;white-space:nowrap;">
  <div class="bash codecolorer">
    <span class="br0">&#91;</span>default<span class="br0">&#93;</span> The guest additions on this VM <span class="kw1">do</span> not match the <span class="kw2">install</span> version of<br /> VirtualBox<span class="sy0">!</span> This may cause things such <span class="kw2">as</span> forwarded ports, shared<br /> folders, and <span class="kw2">more</span> to not work properly. If any of those things fail on<br /> this machine, please update the guest additions and repackage the<br /> box.<br /> <br /> Guest Additions Version: 4.1.0<br /> VirtualBox Version: 4.1.8
  </div>
</div>

J&rsquo;ai trouvé pas mal de solutions, mais trop compliqué et/ou qui télécharges les MAJ sur Internet. Moi je fais comme ça :  
Un petit backup :

<div class="codecolorer-container bash default" style="overflow:auto;white-space:nowrap;">
  <div class="bash codecolorer">
    $ <span class="kw2">tar</span> cvzf ~<span class="sy0">/</span>.vagrant.d<span class="sy0">/</span>backup<span class="sy0">/</span>lucid64.tgz ~<span class="sy0">/</span>.vagrant.d<span class="sy0">/</span>boxes<span class="sy0">/</span>lucid64 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <span class="sy0">!</span><span class="nu0">7295</span><br /> tar: Removing leading <span class="st_h">'/'</span> from member names<br /> a ~<span class="sy0">/</span>.vagrant.d<span class="sy0">/</span>boxes<span class="sy0">/</span>lucid64<br /> a ~<span class="sy0">/</span>.vagrant.d<span class="sy0">/</span>boxes<span class="sy0">/</span>lucid64<span class="sy0">/</span>box-disk1.vmdk<br /> a ~<span class="sy0">/</span>.vagrant.d<span class="sy0">/</span>boxes<span class="sy0">/</span>lucid64<span class="sy0">/</span>box.mf<br /> a ~<span class="sy0">/</span>.vagrant.d<span class="sy0">/</span>boxes<span class="sy0">/</span>lucid64<span class="sy0">/</span>box.ovf<br /> a ~<span class="sy0">/</span>.vagrant.d<span class="sy0">/</span>boxes<span class="sy0">/</span>lucid64<span class="sy0">/</span>Vagrantfile
  </div>
</div>

Dé-commenter la ligne suivante dans le fichier Vagrantfile :

<div class="codecolorer-container ruby default" style="overflow:auto;white-space:nowrap;">
  <div class="ruby codecolorer">
    config.<span class="me1">vm</span>.<span class="me1">boot_mode</span> = <span class="re3">:gui</span>
  </div>
</div>

<div class="codecolorer-container bash default" style="overflow:auto;white-space:nowrap;">
  <div class="bash codecolorer">
    $ vagrant destroy<br /> $ vagrant up<br /> $ vagrant <span class="kw2">ssh</span>
  </div>
</div>

La fenêtre de la VM va s&rsquo;ouvrir en parallèle. Sélectionner cette fenêtre et dans le menu &laquo;&nbsp;Périphérique / installer les additions invitées&nbsp;&raquo;

Donc maintenant nous sommes dans la VM :

<div class="codecolorer-container bash default" style="overflow:auto;white-space:nowrap;">
  <div class="bash codecolorer">
    <span class="co4">vagrant@lucid64:~$ </span><span class="kw2">sudo</span> <span class="kw2">mount</span> <span class="sy0">/</span>dev<span class="sy0">/</span>sr0 <span class="sy0">/</span>mnt<br /> mount: block device <span class="sy0">/</span>dev<span class="sy0">/</span>sr0 is write-protected, mounting read-only<br /> <span class="co4">vagrant@lucid64:~$ </span><span class="kw2">sudo</span> <span class="sy0">/</span>mnt<span class="sy0">/</span>VBoxLinuxAdditions.run <br /> Verifying archive integrity... All good.<br /> Uncompressing VirtualBox 4.1.8 Guest Additions <span class="kw1">for</span> Linux..........<br /> VirtualBox Guest Additions installer<br /> Removing installed version 4.1.0 of VirtualBox Guest Additions...<br /> tar: Record <span class="kw2">size</span> = <span class="nu0">8</span> blocks<br /> Removing existing VirtualBox DKMS kernel modules ...done.<br /> Removing existing VirtualBox non-DKMS kernel modules ...done.<br /> Building the VirtualBox Guest Additions kernel modules<br /> The headers <span class="kw1">for</span> the current running kernel were not found. If the following<br /> module compilation fails <span class="kw1">then</span> this could be the reason.<br /> <br /> Building the main Guest Additions module ...fail<span class="sy0">!</span><br /> <span class="br0">&#40;</span>Look at <span class="sy0">/</span>var<span class="sy0">/</span>log<span class="sy0">/</span>vboxadd-install.log to <span class="kw2">find</span> out what went wrong<span class="br0">&#41;</span><br /> Doing non-kernel setup of the Guest Additions ...done.<br /> Installing the Window System drivers ...fail<span class="sy0">!</span><br /> <span class="br0">&#40;</span>Could not <span class="kw2">find</span> the X.Org or XFree86 Window System.<span class="br0">&#41;</span>
  </div>
</div>

Un petit tour dans le fichier /var/log/vboxadd-install.log nous dis qu&rsquo;il manque les headers du noyau. Pour les installer :

<div class="codecolorer-container bash default" style="overflow:auto;white-space:nowrap;">
  <div class="bash codecolorer">
    <span class="co4">vagrant@lucid64:~$ </span><span class="kw2">sudo</span> <span class="kw2">apt-get install</span> linux-headers-$<span class="br0">&#40;</span><span class="kw2">uname</span> -r<span class="br0">&#41;</span> <span class="re5">-y</span><br /> Reading package lists... Done<br /> Building dependency <span class="kw2">tree</span><br /> Reading state information... Done<br /> The following extra packages will be installed:<br /> &nbsp; linux-headers-2.6.32-<span class="nu0">33</span><br /> The following NEW packages will be installed:<br /> &nbsp; linux-headers-2.6.32-<span class="nu0">33</span> linux-headers-2.6.32-<span class="nu0">33</span>-server<br /> <span class="nu0"></span> upgraded, <span class="nu0">2</span> newly installed, <span class="nu0"></span> to remove and <span class="nu0">5</span> not upgraded.<br /> Need to get 10.7MB of archives.<br /> After this operation, 85.5MB of additional disk space will be used.<br /> Get:<span class="nu0">1</span> http:<span class="sy0">//</span>us.archive.ubuntu.com<span class="sy0">/</span>ubuntu<span class="sy0">/</span> lucid-updates<span class="sy0">/</span>main linux-headers-2.6.32-<span class="nu0">33</span> 2.6.32-<span class="nu0">33.70</span> <span class="br0">&#91;</span>9924kB<span class="br0">&#93;</span><br /> Get:<span class="nu0">2</span> http:<span class="sy0">//</span>us.archive.ubuntu.com<span class="sy0">/</span>ubuntu<span class="sy0">/</span> lucid-updates<span class="sy0">/</span>main linux-headers-2.6.32-<span class="nu0">33</span>-server 2.6.32-<span class="nu0">33.70</span> <span class="br0">&#91;</span>800kB<span class="br0">&#93;</span><br /> Fetched 10.7MB <span class="kw1">in</span> 41s <span class="br0">&#40;</span>255kB<span class="sy0">/</span>s<span class="br0">&#41;</span><br /> Selecting previously deselected package linux-headers-2.6.32-<span class="nu0">33</span>.<br /> <span class="br0">&#40;</span>Reading database ... <span class="nu0">26603</span> files and directories currently installed.<span class="br0">&#41;</span><br /> Unpacking linux-headers-2.6.32-<span class="nu0">33</span> <span class="br0">&#40;</span>from ...<span class="sy0">/</span>linux-headers-2.6.32-<span class="nu0">33</span>_2.6.32-<span class="nu0">33.70</span>_all.deb<span class="br0">&#41;</span> ...<br /> Selecting previously deselected package linux-headers-2.6.32-<span class="nu0">33</span>-server.<br /> Unpacking linux-headers-2.6.32-<span class="nu0">33</span>-server <span class="br0">&#40;</span>from ...<span class="sy0">/</span>linux-headers-2.6.32-<span class="nu0">33</span>-server_2.6.32-<span class="nu0">33.70</span>_amd64.deb<span class="br0">&#41;</span> ...<br /> Setting up linux-headers-2.6.32-<span class="nu0">33</span> <span class="br0">&#40;</span>2.6.32-<span class="nu0">33.70</span><span class="br0">&#41;</span> ...<br /> Setting up linux-headers-2.6.32-<span class="nu0">33</span>-server <span class="br0">&#40;</span>2.6.32-<span class="nu0">33.70</span><span class="br0">&#41;</span> ...<br /> <br /> <span class="co4">vagrant@lucid64:~$ </span><span class="kw2">sudo</span> <span class="sy0">/</span>etc<span class="sy0">/</span>init.d<span class="sy0">/</span>vboxadd<br /> Usage: <span class="sy0">/</span>etc<span class="sy0">/</span>init.d<span class="sy0">/</span>vboxadd <span class="br0">&#123;</span>start<span class="sy0">|</span>stop<span class="sy0">|</span>restart<span class="sy0">|</span>status<span class="sy0">|</span>setup<span class="br0">&#125;</span><br /> <span class="co4">vagrant@lucid64:~$ </span><span class="kw2">sudo</span> <span class="sy0">/</span>etc<span class="sy0">/</span>init.d<span class="sy0">/</span>vboxadd setup<br /> Removing existing VirtualBox DKMS kernel modules ...done.<br /> Removing existing VirtualBox non-DKMS kernel modules ...done.<br /> Building the VirtualBox Guest Additions kernel modules<br /> Building the main Guest Additions module ...done.<br /> Building the shared folder support module ...done.<br /> Building the OpenGL support module ...done.<br /> Doing non-kernel setup of the Guest Additions ...done.<br /> You should restart your guest to <span class="kw2">make</span> sure the new modules are actually used
  </div>
</div>

Un petit reboot pour vérifier que ça fonctionne :

<div class="codecolorer-container bash default" style="overflow:auto;white-space:nowrap;">
  <div class="bash codecolorer">
    $ vagrant halt<br /> <span class="br0">&#91;</span>default<span class="br0">&#93;</span> Attempting graceful shutdown of VM...<br /> $ vagrant up<br /> <span class="br0">&#91;</span>default<span class="br0">&#93;</span> VM already created. Booting <span class="kw1">if</span> it<span class="st_h">'s not already running...<br /> [default] Clearing any previously set forwarded ports...<br /> [default] Forwarding ports...<br /> [default] -- 22 => 2222 (adapter 1)<br /> [default] Creating shared folders metadata...<br /> [default] Clearing any previously set network interfaces...<br /> [default] Booting VM...<br /> [default] Waiting for VM to boot. This can take a few minutes.<br /> [default] VM booted and ready for use!<br /> [default] Mounting shared folders...<br /> [default] -- v-root: /vagrant</span>
  </div>
</div>

Maintenant, transformer la VM en package :

<div class="codecolorer-container bash default" style="overflow:auto;white-space:nowrap;">
  <div class="bash codecolorer">
    $ vagrant package<br /> <span class="br0">&#91;</span>default<span class="br0">&#93;</span> Attempting graceful shutdown of VM...<br /> <span class="br0">&#91;</span>default<span class="br0">&#93;</span> Clearing any previously <span class="kw1">set</span> forwarded ports...<br /> <span class="br0">&#91;</span>default<span class="br0">&#93;</span> Creating temporary directory <span class="kw1">for</span> export...<br /> <span class="br0">&#91;</span>default<span class="br0">&#93;</span> Exporting VM...<br /> <span class="br0">&#91;</span>default<span class="br0">&#93;</span> Compressing package to: ~<span class="sy0">/</span>Vagrant<span class="sy0">/</span>template<span class="sy0">/</span>package.box
  </div>
</div>

Et installer le nouveau package pour remplacer la box :

<div class="codecolorer-container bash default" style="overflow:auto;white-space:nowrap;">
  <div class="bash codecolorer">
    $ vagrant box remove lucid64<br /> <span class="br0">&#91;</span>vagrant<span class="br0">&#93;</span> Deleting box <span class="st_h">'lucid64'</span>...<br /> <br /> $ vagrant box add lucid64 package.box<br /> <span class="br0">&#91;</span>vagrant<span class="br0">&#93;</span> Downloading with Vagrant::Downloaders::File...<br /> <span class="br0">&#91;</span>vagrant<span class="br0">&#93;</span> Copying box to temporary location...<br /> <span class="br0">&#91;</span>vagrant<span class="br0">&#93;</span> Extracting box...<br /> <span class="br0">&#91;</span>vagrant<span class="br0">&#93;</span> Verifying box...<br /> <span class="br0">&#91;</span>vagrant<span class="br0">&#93;</span> Cleaning up downloaded box...
  </div>
</div>

Maintenant, re-commenter la ligne suivante dans le fichier Vagrantfile :

<div class="codecolorer-container ruby default" style="overflow:auto;white-space:nowrap;">
  <div class="ruby codecolorer">
    config.<span class="me1">vm</span>.<span class="me1">boot_mode</span> = <span class="re3">:gui</span>
  </div>
</div>

Pour essayer si la nouvelle box fonctionne :

<div class="codecolorer-container bash default" style="overflow:auto;white-space:nowrap;">
  <div class="bash codecolorer">
    $ vagrant destroy<br /> <span class="br0">&#91;</span>default<span class="br0">&#93;</span> Destroying VM and associated drives...<br /> <br /> $ vagrant up<br /> <span class="br0">&#91;</span>default<span class="br0">&#93;</span> Importing base box <span class="st_h">'lucid64'</span>...<br /> <span class="br0">&#91;</span>default<span class="br0">&#93;</span> Matching MAC address <span class="kw1">for</span> NAT networking...<br /> <span class="br0">&#91;</span>default<span class="br0">&#93;</span> Clearing any previously <span class="kw1">set</span> forwarded ports...<br /> <span class="br0">&#91;</span>default<span class="br0">&#93;</span> Forwarding ports...<br /> <span class="br0">&#91;</span>default<span class="br0">&#93;</span> <span class="re5">--</span> <span class="nu0">22</span> =<span class="sy0">></span> <span class="nu0">2222</span> <span class="br0">&#40;</span>adapter <span class="nu0">1</span><span class="br0">&#41;</span><br /> <span class="br0">&#91;</span>default<span class="br0">&#93;</span> Creating shared folders metadata...<br /> <span class="br0">&#91;</span>default<span class="br0">&#93;</span> Clearing any previously <span class="kw1">set</span> network interfaces...<br /> <span class="br0">&#91;</span>default<span class="br0">&#93;</span> Booting VM...<br /> <span class="br0">&#91;</span>default<span class="br0">&#93;</span> Waiting <span class="kw1">for</span> VM to boot. This can take a few minutes.<br /> <span class="br0">&#91;</span>default<span class="br0">&#93;</span> VM booted and ready <span class="kw1">for</span> use<span class="sy0">!</span><br /> <span class="br0">&#91;</span>default<span class="br0">&#93;</span> Mounting shared folders...<br /> <span class="br0">&#91;</span>default<span class="br0">&#93;</span> <span class="re5">--</span> v-root: <span class="sy0">/</span>vagrant
  </div>
</div>

Si vous avez compris comment mettre à jours la box, immaginez vous faire la même chose avec l&rsquo;installation de middleware (Apache, Nginx, PHP, Rails, &#8230;) <img src="https://blog.ledez.net/wp-includes/images/smilies/simple-smile.png" alt=":)" class="wp-smiley" style="height: 1em; max-height: 1em;" />

Prochain épisode ? Déploiment d&rsquo;un environnement pour héberger du Rails ?

Vous pouvez demander si vous avez d&rsquo;autres idées d&rsquo;articles.

Edit:  
Je me suis posé la question d’où est-ce que je pouvais trouver des boxes toutes prêtes. Parce que bon, Ubuntu 64bits c&rsquo;est bien. Mais moi j&rsquo;ai aussi de la Debian <img src="https://blog.ledez.net/wp-includes/images/smilies/simple-smile.png" alt=":)" class="wp-smiley" style="height: 1em; max-height: 1em;" />  
J&rsquo;ai trouvé http://vagrantbox.es/ et je me suis rendu compte après que [@Ethernitys][3] l&rsquo;avait ajouté dans un Tweet qui concernait cet article.

 [1]: http://blog.ledez.net/wp-content/uploads/2012/02/vagrant.png
 [2]: https://www.virtualbox.org/wiki/Downloads "Le téléchargement de Virtual Box"
 [3]: http://twitter.com/#!/Ethernitys "@Ethernitys"