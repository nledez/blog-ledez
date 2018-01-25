---
title: Première partie - Terraform avec OpenStack
lang: fr
layout: post
permalink: /informatique/devops/premiere-partie-terraform-avec-openstack/
categories:
  - DevOps
tags:
  - devops
  - openstack
  - ovhpubliccloud
  - terraform
  - ansible
excerpt_separator: <!--more-->
---
![PCi, Terraform, Ansible, Consul & Co.]({{ site.url }}/images/2018/01/LogoArticlesPC_Terraform_Ansible_Consul_HAProxy.png)

OK, donc c'est partit !

On va commencer avec Terraform. C'est simple, installe [Terraform](https://www.terraform.io/downloads.html) dans ton PATH.

<!--more-->

Vérifie que la partie [OpenStack](https://www.terraform.io/docs/providers/openstack/index.html) est bien configurée.

Clone [mon entrepôt Git](https://github.com/nledez/consul-laboratory) sur ta machine :
```
$ git clone https://github.com/nledez/consul-laboratory.git
$ cd consul-laboratory
$ ls
README.md                            provision.yml                        terraform.tfvars-example
inventory.ini-example                public-cloud-ovh.auto.tfvars-example variable.tf
main.tf                              requirements.yml
provider.tf                          scripts
```

Copie les fichiers d'exemple :
```
$ cp public-cloud-ovh.auto.tfvars-example public-cloud-ovh.auto.tfvars
$ cp terraform.tfvars-example terraform.tfvars
```

Maintenant, connecte-toi au [manager OVH](https://www.ovh.com/manager/web/login.html) :
![OVH Manager]({{ site.url }}/images/2018/01/post_01_terraform/01-manager.png)

Comme je l'avais dit dans l'article précédent, il faut un projet public cloud avec le Vrack de connecté :
![Public Cloud]({{ site.url }}/images/2018/01/post_01_terraform/02-publiccloud.png)

Clique sur Openstack :
![Openstack]({{ site.url }}/images/2018/01/post_01_terraform/03-openstack.png)

Ensuite sur ajouter un utilisateur :
![Ajouter un utilisateur]({{ site.url }}/images/2018/01/post_01_terraform/04-add-user.png)

L'utilisateur est crée :
![Utilisateur crée]({{ site.url }}/images/2018/01/post_01_terraform/05-user-added.png)

Note bien le mot de passe. C'est le seul moment ou il est affiché. Ensuite, impossible de le retrouver, il faudrait en générer un nouveau (juste le mot de passe).

On va maintenant créer un fichier `openrc.sh` qui va contenir les paramètres openstack :
![Créer un fichier openrc.sh]({{ site.url }}/images/2018/01/post_01_terraform/06-create-openrc.png)

On choisi le datacenter :
![Choix du datacenter]({{ site.url }}/images/2018/01/post_01_terraform/07-select-datacenter.png)

On met le fichier avec les autres :
```
$ mv ~/Download/openrc.sh openrc.sh
# on charge les variables d'environnement (à chaque nouveau shell):
$ source openrc.sh
$ vi -p openrc.sh public-cloud-ovh.auto.tfvars
```

On va remplir les fichiers :

public-cloud-ovh.auto.tfvars :
```
"user_name" = "z9gQ4eJEhG7z"
"tenant_name" = "5898292172448309"
"password" = "AeG6gpgpEjmV9MU52H3eneP6ub74Tt3k"
```

User name c'est la partie de gauche dans le manager OVH.
Le password, c'est la partie de droite qui va être cachée.

Le tenant_name correspond à la variable `OS_TENANT_NAME` dans le fichier openrc.sh

Et moi, je met ça dans le openrc.sh :
```
export OS_PASSWORD="AeG6gpgpEjmV9MU52H3eneP6ub74Tt3k"
```

Bon, il ne faut surtout pas mettre ça sur Github et ne pas partager le fichier.

Ensuite, lance :
```
# Initialisation des "plugins" Terraform :
$ terraform init
# affiche le plan Terraform :
$ terraform plan
# applique les changements :
$ terraform apply
```

On va vérifier qu'Ansible arrive bien à générer un inventory automatiquement :
```
$ terraform-inventory --list terraform.tfstate | jq
{
  "consul": [
    "54.37.21.101",
    "54.37.21.139",
    "54.37.21.129"
  ],
  "consul-client": [
    "54.37.21.107"
  ],
  "consul-client.0": [
    "54.37.21.107"
  ],
  "consul.0": [
    "54.37.21.101"
  ],
  "consul.1": [
    "54.37.21.139"
  ],
  "consul.2": [
    "54.37.21.129"
  ],
  "type_openstack_compute_instance_v2": [
    "54.37.21.107",
    "54.37.21.101",
    "54.37.21.139",
    "54.37.21.129"
  ]
}
```

Bien sûr pour que cela fonctionne, il faut installer [terraform-inventory](https://github.com/adammck/terraform-inventory).

Maintenant test un ping des vm en acceptant les clées SSH :
```
$ export ANSIBLE_NOCOWS=1
$ export ANSIBLE_REMOTE_USER=ubuntu
$ export ANSIBLE_HOSTS=$(which terraform-inventory)
$ ansible --ssh-extra-args='-o StrictHostKeyChecking=no' all -m ping
# maintenant cela doit fonctionner sans le ssh-extra-args :
$ ansible all -m ping
```

Il parait que dans certains cas, la ligne avec le `StrictHostKeyChecking=no` n'est pas indispensable. Ansible pourrait le faire tout seul. Sauf que chez moi non (et chez toi ?).

C'est maintenant la fin de cet article. Tu es peut-être triste. Mais moi fatigué. Je ferais donc la suite un autre jour :)

Je ne vais pas te laisser là quand même. Si tu veux détruire les VM pour économiser un peu de sous avant la prochaine :

```
$ terraform destroy
```

Et puis tu peux voir [le screen cast sur Youtube](https://www.youtube.com/watch?v=m8xJCi8XoU4&feature=youtu.be).

Alors, je suis déçu par la qualité de cette première :
- Image crado
- Son super bas

Promis la prochaine sera meilleure !
