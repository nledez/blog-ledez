---
date: 2022-03-24
title: OVH OpenStack Stein port_security avec Terraform
lang: fr
layout: post
permalink: /informatique/ovh-openstack-stein-port-security-avec-terraform-fr/
categories:
  - Informatique
tags:
  - Informatique
  - terraform
  - ovhpubliccloud
excerpt_separator: <!--more-->
---

![Terraform avec OpenStack Stein]({{ site.url }}/images/2022/03/TerraformStein.png)

[In English]({{ site.url }}/computing/ovh-openstack-stein-port-security-with-terraform-en/)

Si comme moi tu t'es réveillé avec ton plan Terraform qui ne passe plus après
[une mise à jour OVH de l'OpenStack](https://public-cloud.status-ovhcloud.com/incidents/6fh4b3x6plh2)
en version [Stein](https://www.openstack.org/software/stein/).
Ce qui va suivre devrait t'intéresser.

J'avais cette erreur-là :

{% highlight plaintext %}
Exceeded maximum number of retries. Exceeded max scheduling attempts 6 for
instance XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX. Last exception: Network requires
port_security_enabled and subnet associated in order to apply security groups.
{% endhighlight %}

<!--more-->

Concrètement, tu as un plan Terraform comme ceci :

{% highlight javascript %}
# main.tf
resource "openstack_compute_instance_v2" "vm1" {
  name            = "vm1"
  image_name      = "ubuntu"
  flavor_name     = "d1-2"

  security_groups = ["default", "ssh"]

  network {
    name = "Ext-Net"
  }

  network {
    name = "vrack"
  }
}
{% endhighlight %}

Au moment du `terraform apply`, tu as l'erreur ci-dessus. Et même pire que ça,
Terraform tourne en boucle.

C'est le passage en [Stein](https://www.openstack.org/software/stein/) qui est en cause.

Avant, tu avais ta VM. Tu lui spécifiais :
- La liste des réseaux auxquels se rattacher
- La liste des security groups des lesquels mettre la *VM*

Openstack créait automatiquement les ports (interfaces réseau virtuelles) et
Terraform appliquait les security groups à la machine, donc à l'ensemble des
ports (publics comme vrack).


Maintenant, il ne faut appliquer les security groups que sur les ports externes
et non au niveau de l'ensemble des ports.

La bonne nouvelle, c’est qu'à terme on va pouvoir enfin mettre des security groups
aux interfaces assignées aux vracks sur toutes les régions, comme c'est déjà
possible sur GRA9 !!!

Bon, comment tu fais marcher tout ça ?!

{% highlight javascript %}
# main.tf
# Pour avoir les UUID des réseaux plus tard
data "openstack_networking_network_v2" "net_public" {
  name = "Ext-Net"
}

data "openstack_networking_network_v2" "net_vrack" {
  name = vrack
}

# Pour avoir les UUID des security groups plus tard
data "openstack_networking_secgroup_v2" "default" {
  name = "default"
}

data "openstack_networking_secgroup_v2" "ssh" {
  name = "ssh"
}

# Maintenant les ports
# Le public avec les security groups
resource "openstack_networking_port_v2" "public" {
  name       = "vm1-public"
  network_id = data.openstack_networking_network_v2.net_public.id
  security_group_ids = [
    data.openstack_networking_secgroup_v2.default.id,
    data.openstack_networking_secgroup_v2.ssh.id
  ]
  admin_state_up = "true"
}

# Le privé sans security group
resource "openstack_networking_port_v2" "priv" {
  name           = "vm1-priv"
  network_id     = data.openstack_networking_network_v2.net_vrack.id
  admin_state_up = "true"
}

# Et enfin la VM
resource "openstack_compute_instance_v2" "vm1" {
  name            = "vm1"
  image_name      = "ubuntu"
  flavor_name     = "d1-2"

  network {
    port = openstack_networking_port_v2.public.id
  }

  network {
    port = openstack_networking_port_v2.priv.id
  }
}
{% endhighlight %}

Et voilà ! :)
