---
date: 2019-10-09
title: Générer des certificats wildcard avec Terraform
layout: post
permalink: /informatique/générer-des-certificats-wildcard-avec-terraform/
categories:
  - Informatique
tags:
  - Informatique
  - Terraform
  - Letsencrypt
excerpt_separator: <!--more-->
---

![Terraform + Let's Encrypt]({{ site.url }}/images/2019/10/terraform_plus_letsencrypt.png)

Vous connaissez [Terraform](https://www.terraform.io) ? Et [Let's Encrypt](https://letsencrypt.org) ?

Le premier permet de gérer le cycle de vie de vos infrastructures. Et le deuxième vous permet d'avoir des certificats TLS signés par une autorité de certification valide dans les navigateurs modernes.

Dans cet article, je vais vous montrer comment faire un certificat wildcard `*.mondomaine.tld` avec Terraform. La validation avec le protocole acme la plus simple pour ces certificats, est via le DNS. Pour cela, je vais utiliser OVH puisque mon domaine de test est là-bas.

<!--more-->

Bon, ce n'est pas le tout. Mais on n'est pas là pour beurrer des toasts.

Déjà, on va récupérer le repository qui permet de faire tout ça :

{% highlight bash %}
$ git clone https://github.com/nledez/hashicorppourlesnoobs-sources.git demo-terraform-le
$ cd demo-terraform-le/terraform
$ ls
install.sh                 ovh-create-consumer-key.py terraform.tf               variables.tf
lecertificate.tf           requirements.txt           terraform.tfvars
{% endhighlight %}

À quoi servent ces fichiers ?
- `install.sh` -> installer les dépendances
- `requirements.txt` -> les dépendances Python
- `ovh-create-consumer-key.py` -> un script pour simplifier la création du fichier ovh.conf et ovh.sh
- `terraform.tf` -> fichier Terraform qui définit la configuration des providers Terraform
- `variables.tf` -> fichier Terraform qui définit les variables que l'on va utiliser dans notre plan Terraform
- `terraform.tfvars` -> fichier Terraform qui donne les valeurs que l'on va utiliser pour générer notre certificat TLS
- `lecertificate.tf` -> le plan Terraform qui permet de générer le certificat TLS chez Let's Encrypt

On va commencer par installer les prérequis pour causer avec l'API OVH et donc le DNS :

{% highlight bash %}
$ ./install.sh
Running virtualenv with interpreter /usr/local/bin/python3
Already using interpreter /usr/local/opt/python/bin/python3.7
Using base prefix '/usr/local/Cellar/python/3.7.4/Frameworks/Python.framework/Versions/3.7'
New python executable in /private/tmp/demo-terraform-le/terraform/.venv/bin/python3.7
Also creating executable in /private/tmp/demo-terraform-le/terraform/.venv/bin/python
Installing setuptools, pip, wheel...
done.
Collecting ovh==0.5.0 (from -r requirements.txt (line 1))
  Using cached https://files.pythonhosted.org/packages/58/92/db708f5a2e105ca48da1ac065c0168c7626685f9ab3667184dc2d9772bb1/ovh-0.5.0-py2.py3-none-any.whl
Installing collected packages: ovh
Successfully installed ovh-0.5.0
{% endhighlight %}

Ça crée un virtualenv Python pour éviter de pourrir votre machine avec des libs Python. Puis installe la bibliothèque `ovh`.

Maintenant, on va créer le fichier `ovh.conf`

{% highlight bash %}
$ . ./.venv/bin/activate
$ ./ovh-create-consumer-key.py
Need to generate default ovh.conf
Go to https://eu.api.ovh.com/createApp/
Fill form get values and fill ovh.conf with:
application_key =
application_secret =
Now I quit
{% endhighlight %}

Comme l'indique le script, il faut aller sur la page [https://eu.api.ovh.com/createApp/](https://eu.api.ovh.com/createApp/) pour créer le couple `application_key` & application_secret`.

On va rentrer son login/pass OVH puis un nom d'application et une description :

![Création de clée d'API OVH/1]({{ site.url }}/images/2019/10/api-ovh-01.png)

Une fois les application key/secret générées on va les copier pour les mettre dans le fichier `ovh.conf`.

![Création de clée d'API OVH/2]({{ site.url }}/images/2019/10/api-ovh-02.png)

{% highlight bash %}
$ vi ovh.conf
application_key = XXXX
application_secret = XXXX
{% endhighlight %}

On relance le script qui va vérifier que le `consumer_key` est encore valide. Et s'il n'est plus valide ou absent va nous en générer un nouveau.

{% highlight bash %}
$ ./ovh-create-consumer-key.py
Need a valid consumer_key
Please visit https://eu.api.ovh.com/auth/?credentialToken=XXXXXXXX to authenticate
and press Enter to continue...
{% endhighlight %}

Là, soit on est sur un Mac, et ça ouvre automatiquement le lien. Sinon, il faut copier le lien et se connecter pour générer la `consumer_key`.

On rentre son login/pass, puis valide.

![Création de clée d'API OVH/3]({{ site.url }}/images/2019/10/api-ovh-03.png)

On peut fermer cette page, puis retourner sur le terminal.

![Création de clée d'API OVH/4]({{ site.url }}/images/2019/10/api-ovh-04.png)

Une fois fait, appuyer sur entrée.

{% highlight bash %}
Welcome Nicolas
Btw, your "consumerKey" is "XXXXX"
{% endhighlight %}

Le script nous a rendu la main, et a automatiquement mis à jour le fichier `ovh.conf`.

{% highlight bash %}
$ cat ovh.conf
[default]
endpoint = ovh-eu

[ovh-eu]
application_key = XXX
application_secret = XXX
consumer_key = XXX
{% endhighlight %}

On peut même vérifier que le `consumer_key` est toujours valide :

{% highlight bash %}
$ ./ovh-create-consumer-key.py
Welcome Nicolas nothing to do
{% endhighlight %}

On va charger les variables d'environnement qui vont être utilisées par Terraform. Mais aussi éditer le fichier `terraform.tfvars` pour y mettre les bonnes valeurs.

{% highlight bash %}
$ . ./ovh.sh
$ vi terraform.tfvars
{% endhighlight %}

- `parent_domain` -> le nom de domaine racine pour le certificat. Dans mon cas `hashicorp4noobs.fr`
- `subdomain` -> le sous-domaine pour mon wildcard. Je vais mettre `tools`. Au final, mon certificat sera sous la forme `*.tools.hashicorp4noobs.fr`
- `le_email` -> l'email auquel Let's Encrypt va envoyer les messages quand le certificat va expirer

On va en profiter pour éditer le fichier `terraform.tf` et utiliser le serveur de staging Let's Encrypt (`server_url = "https://acme-staging-v02.api.letsencrypt.org/directory"`)

{% highlight bash %}
$ vi terraform.tf
{% endhighlight %}

Et il est maintenant temps d'initialiser Terraform :

{% highlight bash %}
$ terraform init

Initializing the backend...

Initializing provider plugins...
- Checking for available provider plugins...
- Downloading plugin for provider "tls" (hashicorp/tls) 2.1.1...
- Downloading plugin for provider "acme" (terraform-providers/acme) 1.4.0...
- Downloading plugin for provider "local" (hashicorp/local) 1.4.0...

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, it is recommended to add version = "..." constraints to the
corresponding provider blocks in configuration, with the constraint strings
suggested below.

* provider.acme: version = "~> 1.4"
* provider.local: version = "~> 1.4"
* provider.tls: version = "~> 2.1"

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
{% endhighlight %}

Tout s'est bien passé, on va attaquer la suite :

{% highlight bash %}
$ terraform apply

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # acme_certificate.certificate will be created
  + resource "acme_certificate" "certificate" {
      + account_key_pem           = (sensitive value)
      + certificate_domain        = (known after apply)
      + certificate_p12           = (sensitive value)
      + certificate_pem           = (known after apply)
      + certificate_url           = (known after apply)
      + common_name               = "*.tools.hashicorp4noobs.fr"
      + id                        = (known after apply)
      + issuer_pem                = (known after apply)
      + key_type                  = "2048"
      + min_days_remaining        = 30
      + must_staple               = false
      + private_key_pem           = (sensitive value)
      + subject_alternative_names = [
          + "tools.hashicorp4noobs.fr",
        ]

      + dns_challenge {
          + provider = "ovh"
        }
    }

  # acme_registration.local_registration will be created
  + resource "acme_registration" "local_registration" {
      + account_key_pem  = (sensitive value)
      + email_address    = "letsencrypt@hashicorp4noobs.fr"
      + id               = (known after apply)
      + registration_url = (known after apply)
    }

  # local_file.le_tls_certificate will be created
  + resource "local_file" "le_tls_certificate" {
      + content              = (known after apply)
      + directory_permission = "0777"
      + file_permission      = "0644"
      + filename             = "le_tls_certificate.pem"
      + id                   = (known after apply)
    }

  # local_file.le_tls_chain_certificate will be created
  + resource "local_file" "le_tls_chain_certificate" {
      + content              = (known after apply)
      + directory_permission = "0777"
      + file_permission      = "0644"
      + filename             = "le_tls_chain_certificate.pem"
      + id                   = (known after apply)
    }

  # local_file.le_tls_issuer_certificate will be created
  + resource "local_file" "le_tls_issuer_certificate" {
      + content              = (known after apply)
      + directory_permission = "0777"
      + file_permission      = "0644"
      + filename             = "le_tls_issuer_certificate.pem"
      + id                   = (known after apply)
    }

  # local_file.le_tls_private_key will be created
  + resource "local_file" "le_tls_private_key" {
      + content              = (known after apply)
      + directory_permission = "0777"
      + file_permission      = "0600"
      + filename             = "le_tls_private_key.pem"
      + id                   = (known after apply)
    }

  # local_file.le_tls_private_key_file will be created
  + resource "local_file" "le_tls_private_key_file" {
      + content              = (known after apply)
      + directory_permission = "0777"
      + file_permission      = "0777"
      + filename             = "./le_account.key"
      + id                   = (known after apply)
    }

  # tls_private_key.le_tls_private_key will be created
  + resource "tls_private_key" "le_tls_private_key" {
      + algorithm                  = "RSA"
      + ecdsa_curve                = "P224"
      + id                         = (known after apply)
      + private_key_pem            = (sensitive value)
      + public_key_fingerprint_md5 = (known after apply)
      + public_key_openssh         = (known after apply)
      + public_key_pem             = (known after apply)
      + rsa_bits                   = 4096
    }

Plan: 8 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value:
{% endhighlight %}

On tape `yes` puis entrée.

{% highlight bash %}
tls_private_key.le_tls_private_key: Creating...
tls_private_key.le_tls_private_key: Creation complete after 1s [id=517c54bf80a1bf7d67506ad2a8c5bcadc6b80749]
acme_registration.local_registration: Creating...
local_file.le_tls_private_key_file: Creating...
local_file.le_tls_private_key_file: Creation complete after 0s [id=11d0b10f636c0e08e8bf51722544cb1242c1b4c3]
acme_registration.local_registration: Creation complete after 3s [id=https://acme-staging-v02.api.letsencrypt.org/acme/acct/11286586]
acme_certificate.certificate: Creating...
acme_certificate.certificate: Still creating... [10s elapsed]
acme_certificate.certificate: Still creating... [20s elapsed]
acme_certificate.certificate: Still creating... [30s elapsed]
acme_certificate.certificate: Creation complete after 33s [id=https://acme-staging-v02.api.letsencrypt.org/acme/cert/fa901221714abb3504588ce806a6b9838105]
local_file.le_tls_issuer_certificate: Creating...
local_file.le_tls_certificate: Creating...
local_file.le_tls_chain_certificate: Creating...
local_file.le_tls_private_key: Creating...
local_file.le_tls_issuer_certificate: Creation complete after 0s [id=b96fb4b4081d20c510fb1c6daa2256645cbc3c85]
local_file.le_tls_chain_certificate: Creation complete after 0s [id=a265e33f4ed96a3043e97f4a6f7356ce98877c09]
local_file.le_tls_private_key: Creation complete after 0s [id=387b4c339cde6e90d85143b11f0522435a03f174]
local_file.le_tls_certificate: Creation complete after 0s [id=2f0c5d9161d44617802561a2a19cccff506492af]

Apply complete! Resources: 8 added, 0 changed, 0 destroyed.
{% endhighlight %}

Et voilà, tout s'est bien passé. On peut vérifier que les fichiers sont bien là :

{% highlight bash %}
$ ls -1rt | grep '^le'
lecertificate.tf
le_account.key
le_tls_certificate.pem
le_tls_private_key.pem
le_tls_issuer_certificate.pem
le_tls_chain_certificate.pem
{% endhighlight %}

Comme c'était un test, on peut tout supprimer :

{% highlight bash %}
$ terraform destroy
tls_private_key.le_tls_private_key: Refreshing state... [id=517c54bf80a1bf7d67506ad2a8c5bcadc6b80749]
local_file.le_tls_private_key_file: Refreshing state... [id=11d0b10f636c0e08e8bf51722544cb1242c1b4c3]
acme_registration.local_registration: Refreshing state... [id=https://acme-staging-v02.api.letsencrypt.org/acme/acct/11286586]
acme_certificate.certificate: Refreshing state... [id=https://acme-staging-v02.api.letsencrypt.org/acme/cert/fa901221714abb3504588ce806a6b9838105]
local_file.le_tls_issuer_certificate: Refreshing state... [id=b96fb4b4081d20c510fb1c6daa2256645cbc3c85]
local_file.le_tls_certificate: Refreshing state... [id=2f0c5d9161d44617802561a2a19cccff506492af]
local_file.le_tls_private_key: Refreshing state... [id=387b4c339cde6e90d85143b11f0522435a03f174]
local_file.le_tls_chain_certificate: Refreshing state... [id=a265e33f4ed96a3043e97f4a6f7356ce98877c09]

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # acme_certificate.certificate will be destroyed
  - resource "acme_certificate" "certificate" {
      - account_key_pem           = (sensitive value)
      - certificate_domain        = "*.tools.hashicorp4noobs.fr" -> null
      - certificate_p12           = (sensitive value)
      - certificate_pem           = "-----BEGIN CERTIFICATE-----\n[...]\n-----END CERTIFICATE-----\n" -> null
      - certificate_url           = "https://acme-staging-v02.api.letsencrypt.org/acme/cert/fa901221714abb3504588ce806a6b9838105" -> null
      - common_name               = "*.tools.hashicorp4noobs.fr" -> null
      - id                        = "https://acme-staging-v02.api.letsencrypt.org/acme/cert/fa901221714abb3504588ce806a6b9838105" -> null
      - issuer_pem                = "-----BEGIN CERTIFICATE-----\n[...]\n-----END CERTIFICATE-----\n" -> null
      - key_type                  = "2048" -> null
      - min_days_remaining        = 30 -> null
      - must_staple               = false -> null
      - private_key_pem           = (sensitive value)
      - subject_alternative_names = [
          - "tools.hashicorp4noobs.fr",
        ] -> null

      - dns_challenge {
          - config   = (sensitive value)
          - provider = "ovh" -> null
        }
    }

  # acme_registration.local_registration will be destroyed
  - resource "acme_registration" "local_registration" {
      - account_key_pem  = (sensitive value)
      - email_address    = "letsencrypt@hashicorp4noobs.fr" -> null
      - id               = "https://acme-staging-v02.api.letsencrypt.org/acme/acct/XXXX" -> null
      - registration_url = "https://acme-staging-v02.api.letsencrypt.org/acme/acct/XXXX" -> null
    }

  # local_file.le_tls_certificate will be destroyed
  - resource "local_file" "le_tls_certificate" {
      - content              = "-----BEGIN CERTIFICATE-----\n[...]\n-----END CERTIFICATE-----\n" -> null
      - directory_permission = "0777" -> null
      - file_permission      = "0644" -> null
      - filename             = "le_tls_certificate.pem" -> null
      - id                   = "XXX" -> null
    }

  # local_file.le_tls_chain_certificate will be destroyed
  - resource "local_file" "le_tls_chain_certificate" {
      - content              = "-----BEGIN CERTIFICATE-----\n[...]\n-----END CERTIFICATE-----\n-----BEGIN CERTIFICATE-----\n[...]\n-----END CERTIFICATE-----\n" -> null
      - directory_permission = "0777" -> null
      - file_permission      = "0644" -> null
      - filename             = "le_tls_chain_certificate.pem" -> null
      - id                   = "XXX" -> null
    }

  # local_file.le_tls_issuer_certificate will be destroyed
  - resource "local_file" "le_tls_issuer_certificate" {
      - content              = "-----BEGIN CERTIFICATE-----\n[...]\n-----END CERTIFICATE-----\n" -> null
      - directory_permission = "0777" -> null
      - file_permission      = "0644" -> null
      - filename             = "le_tls_issuer_certificate.pem" -> null
      - id                   = "XXX" -> null
    }

  # local_file.le_tls_private_key will be destroyed
  - resource "local_file" "le_tls_private_key" {
      - content              = "-----BEGIN RSA PRIVATE KEY-----\n[...]\n-----END RSA PRIVATE KEY-----\n" -> null
      - directory_permission = "0777" -> null
      - file_permission      = "0600" -> null
      - filename             = "le_tls_private_key.pem" -> null
      - id                   = "XXX" -> null
    }

  # local_file.le_tls_private_key_file will be destroyed
  - resource "local_file" "le_tls_private_key_file" {
      - content              = "-----BEGIN RSA PRIVATE KEY-----\n[...]\n-----END RSA PRIVATE KEY-----\n" -> null
      - directory_permission = "0777" -> null
      - file_permission      = "0777" -> null
      - filename             = "./le_account.key" -> null
      - id                   = "XXX" -> null
    }

  # tls_private_key.le_tls_private_key will be destroyed
  - resource "tls_private_key" "le_tls_private_key" {
      - algorithm                  = "RSA" -> null
      - ecdsa_curve                = "P224" -> null
      - id                         = "XXX" -> null
      - private_key_pem            = (sensitive value)
      - public_key_fingerprint_md5 = "XXX" -> null
      - public_key_openssh         = "XXX" -> null
      - public_key_pem             = "-----BEGIN PUBLIC KEY-----\n[...]\n-----END PUBLIC KEY-----\n" -> null
      - rsa_bits                   = 4096 -> null
    }

Plan: 0 to add, 0 to change, 8 to destroy.

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

local_file.le_tls_issuer_certificate: Destroying... [id=b96fb4b4081d20c510fb1c6daa2256645cbc3c85]
local_file.le_tls_chain_certificate: Destroying... [id=a265e33f4ed96a3043e97f4a6f7356ce98877c09]
local_file.le_tls_private_key_file: Destroying... [id=11d0b10f636c0e08e8bf51722544cb1242c1b4c3]
local_file.le_tls_private_key: Destroying... [id=387b4c339cde6e90d85143b11f0522435a03f174]
local_file.le_tls_certificate: Destroying... [id=2f0c5d9161d44617802561a2a19cccff506492af]
local_file.le_tls_private_key_file: Destruction complete after 0s
local_file.le_tls_certificate: Destruction complete after 0s
local_file.le_tls_private_key: Destruction complete after 0s
local_file.le_tls_issuer_certificate: Destruction complete after 0s
local_file.le_tls_chain_certificate: Destruction complete after 0s
acme_certificate.certificate: Destroying... [id=https://acme-staging-v02.api.letsencrypt.org/acme/cert/fa901221714abb3504588ce806a6b9838105]
acme_certificate.certificate: Destruction complete after 2s
acme_registration.local_registration: Destroying... [id=https://acme-staging-v02.api.letsencrypt.org/acme/acct/11286586]
acme_registration.local_registration: Destruction complete after 1s
tls_private_key.le_tls_private_key: Destroying... [id=517c54bf80a1bf7d67506ad2a8c5bcadc6b80749]
tls_private_key.le_tls_private_key: Destruction complete after 0s

Destroy complete! Resources: 8 destroyed.
{% endhighlight %}

Et voilà, vous savez :
- Utiliser Terraform
- Avec Let's encrypt
- Créer des fichiers en local

Si votre DNS n'est pas chez OVH, vous pouvez changer le `dns_challenge` `provider = "ovh"` dans le fichier `lecertificate.tf`.

Voici la [liste des providers DNS](https://www.terraform.io/docs/providers/acme/dns_providers/index.html) ainsi que leurs documentations respectives.
