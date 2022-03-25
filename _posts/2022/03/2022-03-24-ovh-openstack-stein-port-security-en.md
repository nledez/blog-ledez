---
date: 2022-03-23
title: OVH OpenStack Stein port_security with Terraform
lang: en
layout: post
permalink: /computing/ovh-openstack-stein-port-security-with-terraform-en/
categories:
  - Computing
tags:
  - computing
  - terraform
  - ovhpubliccloud
excerpt_separator: <!--more-->
---

![Terraform avec OpenStack Stein]({{ site.url }}/images/2022/03/TerraformStein.png)

[En français]({{ site.url }}/informatique/ovh-openstack-stein-port-security-avec-terraform-fr/)

If like me you woke up with your Terraform plan no longer passing after
[an OVH update of the OpenStack](https://public-cloud.status-ovhcloud.com/incidents/6fh4b3x6plh2)
to [Stein](https://www.openstack.org/software/stein/).
What follows should be of interest to you.

I had this error:

{% highlight plaintext %}
Exceeded maximum number of retries. Exceeded max scheduling attempts 6 for
instance XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX. Last exception: Network requires
port_security_enabled and subnet associated in order to apply security groups.
{% endhighlight %}

<!--more-->

Concretely, you have a Terraform plan like this:

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

At the time of the `terraform apply`, you have the above error. And even worse than that,
Terraform is running in a loop.

It is the change to [Stein](https://www.openstack.org/software/stein/) which is in cause.

Before, you had your VM. You would specify to it:
- The list of networks to attach to
- The list of security groups to put the *VM* in

Openstack automatically created the ports (virtual network interfaces) and
Terraform applied the security groups to the machine, i.e. to all the ports (public as well as
ports (both public and vrack).

Now, you have to apply security groups only on external ports
and not on all ports.

The good news is that in the future we will finally be able to put security groups
to the interfaces assigned to the vracks on all the regions, as it is already
possible on GRA9 !!!

Well, how do you make it all work?!

{% highlight javascript %}
# main.tf
# To have the UUID of the networks later
data "openstack_networking_network_v2" "net_public" {
  name = "Ext-Net"
}

data "openstack_networking_network_v2" "net_vrack" {
  name = vrack
}

# To have the UUID of the security groups later
data "openstack_networking_secgroup_v2" "default" {
  name = "default"
}

data "openstack_networking_secgroup_v2" "ssh" {
  name = "ssh"
}

# Now the ports
# Public with security groups
resource "openstack_networking_port_v2" "public" {
  name       = "vm1-public"
  network_id = data.openstack_networking_network_v2.net_public.id
  security_group_ids = [
    data.openstack_networking_secgroup_v2.default.id,
    data.openstack_networking_secgroup_v2.ssh.id
  ]
  admin_state_up = "true"
}

# Private without security group
resource "openstack_networking_port_v2" "priv" {
  name           = "vm1-priv"
  network_id     = data.openstack_networking_network_v2.net_vrack.id
  admin_state_up = "true"
}

# And finally the VM
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

And voila! :)
