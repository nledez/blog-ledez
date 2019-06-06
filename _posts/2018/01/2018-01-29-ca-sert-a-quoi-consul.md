---
title: Ca sert à quoi Consul ?
lang: fr
layout: post
permalink: /informatique/devops/ca-sert-a-quoi-consul-/
categories:
  - DevOps
tags:
  - devops
  - consul
excerpt_separator: <!--more-->
---
![PCi, Terraform, Ansible, Consul & Co.]({{ site.url }}/images/2018/01/LogoArticlesPC_Terraform_Ansible_Consul_HAProxy.png)

[Nicolas me demandait dans un autre billet]({{ site.baseurl }}/informatique/devops/premiere-partie-terraform-avec-openstack/) :

> Pas l'objet principal de ton article, mais concrètement à quoi ça sert Consul ? Quelle utilisation en as-tu ?
> 
> Sinon, une raison particulière à utiliser terraform-inventory plutôt que l'inventaire dynamique fournit par OpenStack ?

Comme répondre à tout cela ferait un commentaire très long, un article en plus, c'est encore mieux :)

<!--more-->

Consul c'est quoi ? On va s'inspirer de [Introduction to Consul](https://www.consul.io/intro/index.html) :
* Multicentre de données (datacenter). C'est un outil simplifier la vie des administrateurs système. C'est prévu de base pour fonctionner sur plusieurs datacenters. Les données se répliquent, et en toute logique c'est en cluster. Et ça fonctionne super bien.
* Une base de donnée clé/valeur. Dans Consul tout est stocké dans la base de données. Chaque valeur y est stockée dans une clé. Il y a une hiérarchie avec des dossiers et tout. Et accessible via une API REST.
* Service de découverte. Dans ces valeurs, on peut y trouver des inventaires de services. Dans l'exemple que je prendrais plus tard, je veux mettre X serveurs d'application Python. Pour configurer mon Haproxy, je vais aller chercher la liste des serveurs dans Consul.
* Test de vie. Et justement, pour avoir la liste de mes serveurs d'application Python, je vais installer un agent Consul sur chaque machine et lui ajouter un test de vie. Dés que le serveur est prêt, il en informe consul qui va mettre à jours la configuration haproxy automagiquement. Et pareil quand le serveur sera arrêté.

Ça peut servir à plein d'autres choses :
* Stocker les configurations de services
* Stocker les secrets (avec Vault)
* Monitoring (serveur OK/KO toussa)

Ensuite, pourquoi utiliser terraform-inventory ?
* Ça fonctionne automatiquement avec le tfstate
* Quel que soit le provider (Openstack, autre chose)
* Je peux avoir autre chose dans mon projet Openstack et je ne veux pas y toucher :p

Voilà Nicolas. Est-ce que ça répond à tes questions ?
