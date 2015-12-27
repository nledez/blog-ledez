---
id: 536
title: 'Slides &laquo;&nbsp;Git en 10 minutes&nbsp;&raquo; du Devcamp #5 en ligne'
author: Nicolas Ledez
layout: post
guid: http://blog.ledez.net/?p=536
permalink: /informatique/slides-git-en-10-minutes-du-devcamp-5-en-ligne/
categories:
  - Informatique
  - OpenSource
tags:
  - git
  - slides
excerpt_separator: <!--more-->
---
Les slides &laquo;&nbsp;Git en 10 minutes&nbsp;&raquo; que j&rsquo;ai présentées ce soir au Devcamp #5 sont en ligne ici :

<!--more-->



<div style="margin-bottom: 5px;">
  <strong> <a title="Git en 10 minutes" href="http://www.slideshare.net/nledez/10-minutes-pour-git" target="_blank">Git en 10 minutes</a> </strong> from <strong><a href="http://www.slideshare.net/nledez" target="_blank">Nicolas Ledez</a></strong>
</div>

{% highlight bash %}
user1$ . ~/git-change-author woot1
Loaded: Woot en haut <woot@en.haut>
user1$ mkdir woot ; cd woot
user1$ git init ; git commit -m "Empty commit" --allow-empty
Initialized empty Git repository in /Users/nico/Devs/git/woot-dir/woot/.git/
[master (root-commit) 03fff56] Empty commit
user1$ echo 'A powwerwull tooool wooooot !!!11!!!' > README
user1$ git status
# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       README
nothing added to commit but untracked files present (use "git add" to track)
user1$ git add README
user1$ git commit -m "Add README file"
[master 4c4cf98] Add README file
 1 file changed, 1 insertion(+)
 create mode 100644 README
user1$ git clone --bare woot
Cloning into bare repository 'woot.git'...
done.
user1$ cd woot
user1$ git remote -v
user1$ git remote add origin ../woot.git
user1$ git remote -v                    
origin  ../woot.git (fetch)
origin  ../woot.git (push)
user1$ git log        
commit 4c4cf9861d129c9ece8e7c7d95a81e7062463659
Author: Woot en haut <woot@en.haut>
Date:   Wed Feb 13 22:34:51 2013 +0100

    Add README file

commit 03fff5607971a750c0436de90ffb7cf1f69c638e
Author: Woot en haut <woot@en.haut>
Date:   Wed Feb 13 22:32:18 2013 +0100

    Empty commit
user2$ pwd
/Users/nico/Devs/git/woot-dir
user2$ git clone woot.git woot-user2
Cloning into 'woot-user2'...
done.
user2$ cd woot-user2
user2$ git remote -v
origin  /Users/nico/Devs/git/woot-dir/woot.git (fetch)
origin  /Users/nico/Devs/git/woot-dir/woot.git (push)
user1$ echo 'User 1 add a file' > file1
user1$ git add file1
user1$ git commit -m "Add file1"  
[master 8b66ba5] Add file1
 1 file changed, 1 insertion(+)
 create mode 100644 file1
user1$ git push
Counting objects: 4, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (3/3), 279 bytes, done.
Total 3 (delta 0), reused 0 (delta 0)
To ../woot.git
   4c4cf98..8b66ba5  master -> master
user2$ echo 'User 2 add a file' > file2
user2$ git add file2 ; git commit -m "Add file2"
[master 816c64e] Add file2
 1 file changed, 1 insertion(+)
 create mode 100644 file2
user2$ git push
To /Users/nico/Devs/git/woot-dir/woot.git
 ! [rejected]        master -> master (non-fast-forward)
error: failed to push some refs to '/Users/nico/Devs/git/woot-dir/woot.git'
hint: Updates were rejected because the tip of your current branch is behind
hint: its remote counterpart. Merge the remote changes (e.g. 'git pull')
hint: before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.
user2$ git pull
remote: Counting objects: 4, done.
remote: Compressing objects: 100% (2/2), done.
remote: Total 3 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
From /Users/nico/Devs/git/woot-dir/woot
   4c4cf98..8b66ba5  master     -> origin/master
Merge made by the 'recursive' strategy.
 file1 | 1 +
 1 file changed, 1 insertion(+)
# BEGIN FILE #####
Merge branch 'master' of /Users/nico/Devs/git/woot-dir/woot

# Please enter a commit message to explain why this merge is necessary,
# especially if it merges an updated upstream into a topic branch.
#
# Lines starting with '#' will be ignored, and an empty message aborts
# the commit.
# END FILE #####
 create mode 100644 file1
user2$ git push
Counting objects: 7, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (4/4), done.
Writing objects: 100% (5/5), 607 bytes, done.
Total 5 (delta 0), reused 0 (delta 0)
To /Users/nico/Devs/git/woot-dir/woot.git
   8b66ba5..8bc04de  master -> master
user1$ git pull
remote: Counting objects: 7, done.
remote: Compressing objects: 100% (4/4), done.
remote: Total 5 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (5/5), done.
From ../woot
   8b66ba5..8bc04de  master     -> origin/master
There is no tracking information for the current branch.
Please specify which branch you want to merge with.
See git-pull(1) for details

    git pull <remote> <branch>

If you wish to set tracking information for this branch you can do so with:

    git branch --set-upstream-to=origin/<branch> master

user1$ git pull
user1$ git branch --set-upstream-to=origin/master master  
Branch master set up to track remote branch master from origin.
user1$ git pull                                        
Updating 8b66ba5..8bc04de
Fast-forward
 file2 | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 file2
user1$ echo 'A mod' >> README
user1$ git commit -am "A mod in README"          
[master e955015] A mod in README
 1 file changed, 1 insertion(+)
user1$ git push
Counting objects: 5, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (3/3), 333 bytes, done.
Total 3 (delta 0), reused 0 (delta 0)
To ../woot.git
   8bc04de..e955015  master -> master
user2$ echo "Another update" >> README
user2$ git commit -am "Update README"
[master cd8057c] Update README
 1 file changed, 1 insertion(+)
user2$ git pull
remote: Counting objects: 5, done.
remote: Compressing objects: 100% (2/2), done.
remote: Total 3 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
From /Users/nico/Devs/git/woot-dir/woot
   8bc04de..e955015  master     -> origin/master
Auto-merging README
CONFLICT (content): Merge conflict in README
Automatic merge failed; fix conflicts and then commit the result.
user2$ cat README
A powwerwull tooool wooooot !!!11!!!
<<<<<<< HEAD
Another update
=======
A mod
>>>>>>> e9550154ae16b0f43431e9dfbb53287803f67f9c
user2$ vi README # Fix README
user2$ git status
# On branch master
# Your branch and 'origin/master' have diverged,
# and have 1 and 1 different commit each, respectively.
#   (use "git pull" to merge the remote branch into yours)
#
# You have unmerged paths.
#   (fix conflicts and run "git commit")
#
# Unmerged paths:
#   (use "git add <file>..." to mark resolution)
#
#   both modified:      README
#
no changes added to commit (use "git add" and/or "git commit -a")
user2$ git add README ; git commit -m "Merge and fix conflicts"
[master 8fce8a6] Merge and fix conflicts
user2$ git push
Counting objects: 8, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (4/4), done.
Writing objects: 100% (4/4), 472 bytes, done.
Total 4 (delta 1), reused 0 (delta 0)
To /Users/nico/Devs/git/woot-dir/woot.git
   e955015..8fce8a6  master -> master
user1$ git pull
remote: Counting objects: 8, done.
remote: Compressing objects: 100% (4/4), done.
remote: Total 4 (delta 1), reused 0 (delta 0)
Unpacking objects: 100% (4/4), done.
From ../woot
   e955015..8fce8a6  master     -> origin/master
Updating e955015..8fce8a6
Fast-forward
 README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
{% endhighlight %}

Toutes ces commandes donnent ça :  
[<img src="/images/2013/02/by-default-2013-02-13-at-22.55.41.png" alt="Git &quot;workflow&quot;" class="alignnone size-medium wp-image-545" />][1]

 [1]: 2013/02/by-default-2013-02-13-at-22.55.41.png
