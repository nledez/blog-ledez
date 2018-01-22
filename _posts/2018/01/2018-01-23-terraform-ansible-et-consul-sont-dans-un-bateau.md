---
title: Terraform, Ansible et Consul sont dans un bateau
lang: fr
layout: post
permalink: /informatique/devops/terraform-ansible-et-consul-sont-dans-un-bateau/
categories:
  - DevOps
tags:
  - devops
  - openstack
  - ovhpubliccloud
  - terraform
  - ansible
  - consul
excerpt_separator: <!--more-->
---
![PCi, Terraform, Ansible, Consul & Co.]({{ site.url }}/images/2018/01/LogoArticlesPC_Terraform_Ansible_Consul_HAProxy.png)

Je prépare une série d'articles sur [Consul](https://www.consul.io/) de chez [Hashicorp](https://www.hashicorp.com/) :
- Monter un Cluster
- Activer le chiffrement
- Mettre en place du TLS
- Mettre en place des ACL
- Surveiller des services
- Générer une configuration [HAProxy](https://www.haproxy.org/) qui se met à jour dynamiquement

<!--more-->

Mais pour que tu puisses jouer avec tout cela toi même, je prépare aussi :
- Un plan Terraform pour le [Public Cloud d'OVH](https://www.ovh.com/fr/public-cloud/instances/)
- Des playbooks [Ansible](https://www.ansible.com/)

Au préalable, il va te falloir :
- Un compte OVH
- Un projet public Cloud
- Un réseau privé d'activé sur le projet OpenStack (vrack)

Commence par te familiariser avec l'infra Openstack d'OVH (c'est avec ça que tourne le public cloud).

La [documentation](https://docs.ovh.com/fr/public-cloud/) est bien foutue.

Pour configurer le vrack sur le projet, cela se passe par là :
[Utiliser le vRack et les réseaux privés avec les instances Public Cloud](https://docs.ovh.com/fr/public-cloud/utiliser-le-vrack-et-les-reseaux-prives-avec-les-instances-public-cloud/)

Si tu ne comprends pas grand-chose à tout cela, il y a de fortes chances que ce soit pire un peu plus tard...
