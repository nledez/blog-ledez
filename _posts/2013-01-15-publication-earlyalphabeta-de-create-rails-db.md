---
id: 525
title: 'Publication &laquo;&nbsp;early/alpha/beta&nbsp;&raquo; de create-rails-db'
author: Nicolas Ledez
layout: post
guid: http://blog.ledez.net/?p=525
permalink: /opensource/publication-earlyalphabeta-de-create-rails-db/
categories:
  - OpenSource
  - Rails
  - Ruby
  - Tips
tags:
  - rails
  - ruby
---
Suite à une discussion sur l&rsquo;article : [http://www.synbioz.com/blog/ruby\_sql\_cheat_sheet][1]

J&rsquo;ai mis sur [Github mon script de création de bases de données Mysql pour Rails][2]

Mode d&#8217;emploi :

Une fois le «rails new my-awesome-app -d mysql » terminé, on va modifier les infos dans le «config/database.yml» :

  * username : m-a-app\_dev, m-a-app\_tst, m-a-app_prd
  * database : mettre la même chose que username
  * password : j’utilise «apg -q -m12» pour générer des mots de passe

Attention aux noms des bases, ils ne peuvent pas être trop longs.

Ensuite, on lance mon script dans le répertoire de mon application «et voilà» !

 [1]: http://www.synbioz.com/blog/ruby_sql_cheat_sheet
 [2]: https://github.com/nledez/create-rails-db/blob/master/create-rails-db.rb "Github mon script de création de bases de données Mysql pour Rails"