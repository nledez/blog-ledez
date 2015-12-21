---
id: 336
title: Array ruby tricks
author: Nicolas Ledez
layout: post
guid: http://blog.ledez.net/?p=336
permalink: /informatique/array-ruby-tricks/
categories:
  - Informatique
  - Ruby
  - Tips
tags:
  - array
  - ruby
  - tips
---
J&rsquo;en ai parlé lors de ma session aux MS Techdays.

On vous donne 2 fichiers :

  * Le fichier avec les UUID à enlever
  * Le fichier avec tous les UUID

Le chalenge, ne garder que les UUID absent :p

Les armes :

  * Ruby
  * Ben&#8230; c&rsquo;est tout

<!--more-->

{% highlight ruby %}
# Initialisation des variables, je vais utiliser 2 tableaux
remove = []

# J'ouvre les fichiers, et pour chaque ligne la pousser dans son tableau.
# Pour l'exemple, j'utilise 2 méthodes pour remplir les tableaux
all = File.readlines("01-all.csv")
File.open("02-to-remove.csv").each { |l| remove << l }

# Afficher le nombre d'éléments dans chaque tableau
puts "All: #{all.count}"
puts "Remove: #{remove.count}"

# La partie intéressante : la soustraction
keep = all - remove

# J'affiche le nombre d'éléments dans le tableau restant
puts "Keep: #{keep.count}"

# Et vérifie si le nombre d'éléments correspond à ce que je voudrais
puts "Groovy !!!" if keep.count == (all.count - remove.count)

# J'enregistre le résultat dans un fichier
file = File.open("03-to-keep.csv", "w+")
keep.each { |lun| file.puts lun }
file.close>>}
{% endhighlight %}

Le résultat :

{% highlight ruby %}
All: 31
Remove: 7
Keep: 24
Groovy !!!
{% endhighlight %}

La version courte de &laquo;&nbsp;prod&nbsp;&raquo; :

{% highlight ruby %}
remove = []

all = File.readlines("01-all.csv")
File.open("02-to-remove.csv").each { |l| remove.push l }

keep = all - remove

file = File.open("03-to-keep.csv", "w+")
keep.each { |lun| file.puts lun }
file.close
{% endhighlight %}

Si vous voulez générer des fichiers pour faire le test vous même :

{% highlight ruby %}
all = File.open("01-all.csv", "w")
remove = File.open("02-to-remove.csv", "w")

(0..30).each do
  val = rand(10000000000000)
  all.puts val
  remove.puts val if rand(5) > 3
end

remove.close
all.close
{% endhighlight %}

Edit: Sur une suggestion de Ghislain, j&rsquo;ai modifié le code d&rsquo;exemple pour ajouter une variante plus courte
