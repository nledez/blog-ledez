---
date: 2019-09-16
title: How to recover a 'rm -rf /var/lib/mysql/*'
author: Nicolas Ledez
lang: en
layout: post
permalink: /informatique/how-to-recover-a-rm-rf-var-lib-mysql/
categories:
  - Informatique
tags:
  - Informatique
  - sysadmin
  - Mysql
excerpt_separator: <!--more-->
---
![Mysql crash]({{ site.url }}/images/2019/09/MysqlCrash.jpg)

There's a saying I like:
> In life, there are two types of system administrators:
> The one who has already made a big mistake in production
> And the one that will soon be

Well, I just moved from the second to the first category in a command line:

{% highlight bash %}
cd /var/lib/mysql
rm -rf *
{% endhighlight %}

And of course on the production server, and not on the future one.

In short, the BIG dumpling. On an 80GB database that takes several hours to restore.

And very big spoiler, we managed to restore everything.

Before I read on, I don't guarantee that this will work for you. And declines any responsibility if you lose your data.

But you may be happy to be able to get as much of your bases/tables as possible.

<!--more-->

First of all, the first thing to do is to cut off any activity that may be present on this instance:
- Shutdown applications can access to Mysql
- Put an iptable rule

Whatever, but above all, reduce access to this instance.

The second thing to keep in mind, DO NOT STOP Mysql. That's what's going to save us.

I have since written a Python script that will allow me to save as much as possible.

Then I will quickly explain why all this can work.

But first, here's how to reproduce this in your home (in a Vagant). Don't try that on a real server.

# Setting up the test environment

We're going to use [Vagrant](https://www.vagrantup.com)

{% highlight bash %}
git clone https://github.com/nledez/recover_deleted_mysql.git
cd recover_deleted_mysql
vagrant up
vagrant ssh
# From there, we are in the Vagrant VM.
# Before doing dangerous operations, make sure you are always there...
# The prompt must be: vagrant@ubuntu-bionic

# We're going to load test data into Mysql
git clone https://github.com/datacharmer/test_db.git
cd test_db
cat employees.sql | sudo mysql

# We display the list of bases to check that the import has worked well
echo 'show databases;' | sudo mysql

# We'll make a backup for later (you still need one, and it will allow you to restart the test from there)
sudo service mysql stop
sudo mkdir /backup
sudo rsync -av /var/lib/mysql/ /backup/
sudo chmod 777 /backup
sudo service mysql start
sudo bash /vagrant/read_all_data.sh
# The last command lists all the data from all the tables, so that everything can be loaded into memory.

# It's time to destroy all database files (it's especially that part you never do in production)
sudo find /var/lib/mysql -type f -exec rm {} \;
sudo find /var/lib/mysql -type d -exec rmdir {} \;
# Ouupppsss
sudo ls -la /var/lib/mysql/
# And now we're going to check that it's the big shit in production:
echo 'show databases;' | sudo mysql
{% endhighlight %}

# We're going to start the restoration:

{% highlight bash %}
# We create a directory in which we will put the files we will recover (we will need the place of the old /var/lib/mysql)
sudo mkdir /recover
# We're going to get the PID from the Mysql process
ps ax | grep [m]ysqld
# We will store it in a variable (it's easier for the rest of the article)
MYSQL_PID=2530
# We're going to do a `lsof` that will show us why we're going to be able to recover the disaster
sudo lsof -p $MYSQL_PID
{% endhighlight %}

## And now, let's let the magic work.

### The script in `--help` mode

{% highlight bash %}
$ sudo /vagrant/recover_deleted_mysql.py --help
usage: recover_deleted_mysql.py [-h] --pid PID [--recover_path RECOVER_PATH]
                                [--mysql_path MYSQL_PATH] [--touch_files]
                                [--export_as_csv EXPORT_AS_CSV [EXPORT_AS_CSV ...]]
                                [--csv_path CSV_PATH]

Mysql recuperator

optional arguments:
  -h, --help            show this help message and exit
  --pid PID             PID of Mysql process
  --recover_path RECOVER_PATH
                        Path of directory if you want revover deleted files
  --mysql_path MYSQL_PATH
                        Path of mysql directory if you want limit recovery
  --touch_files         If you want touch deleted files
  --export_as_csv EXPORT_AS_CSV [EXPORT_AS_CSV ...]
                        List of databases to export require --csv_path
                        argument
  --csv_path CSV_PATH   Path of csv export
{% endhighlight %}

### Recovery of deleted files

{% highlight bash %}
sudo /vagrant/recover_deleted_mysql.py --pid $MYSQL_PID --mysql_path /var/lib/mysql --recover_path /recover
# And we can check with the command `sudo find /recover -ls`
{% endhighlight %}

### Extraction of data in CSV formats for greater security

Well, if the database is ever corrupted, we'll be happy to have the data in CSV format.
However, in my tests, I had a lot of crashes with the Mysql engine, so you have to be very careful with the controls.
But also to think that it might crash and that we'll lose everything.

{% highlight bash %}
# First step, we'll do a touch of the files that have been deleted (yes, it sounds stupid, but it works)
sudo /vagrant/recover_deleted_mysql.py --pid $MYSQL_PID --mysql_path /var/lib/mysql --touch_files
# VERY important, change the permissions of directories and files before doing anything (this is where Mysql can crash)
sudo chown -R mysql:mysql /var/lib/mysql
# Now, we can list the DBs
echo 'show databases;' | sudo mysql
# But we don't see the tables yet
echo 'show tables;' | sudo mysql employees
# We need the.frm files that contain the table structures (so we need a backup of these files on hand)
cd /backup/
sudo find * -name '*.frm' -exec cp {} /var/lib/mysql/{} \;
sudo chown -R mysql:mysql /var/lib/mysql
echo 'show tables;' | sudo mysql employees
# And now we can make selections in the tables. But no mysqldump and especially in my tests, it made Mysql crash :(
# DO NOT start mysqldump until you have finished all this
# In a "normal" installation, Mysql cannot write a file anywhere. We're going to look for the path that's configured:
echo 'SHOW VARIABLES LIKE "secure_file_priv";' | sudo mysql # Get /var/lib/mysql-files/
# And we start exporting
sudo /vagrant/recover_deleted_mysql.py --pid $MYSQL_PID --csv_path /var/lib/mysql-files --export_as_csv employees
{% endhighlight %}

And voilà!

### Put the data back in place

{% highlight bash %}
# Restored files are copied to the Mysql directory:
sudo rsync -av /recover/var/lib/mysql/ /var/lib/mysql/
# We're arresting Mysql
sudo service mysql stop
# We give the right rights back
sudo chown -R mysql:mysql /var/lib/mysql
# We're relaunching Mysql
sudo service mysql start
# We're asking Mysql to do a check of the databases
sudo mysqlcheck --all-databases
# Launch a `mysql_upgrade` that restores all system bases/tables to working order
sudo mysql_upgrade
# We're relaunching Mysql
sudo service mysql restart
# We restart a Mysqldump to make sure that the database works again well
cd
sudo mysqldump employees > employees.sql
{% endhighlight %}

## Various instructions

- Never stop Mysql, never, never, never, never, never, never, never, never, never
- Do not try to mysqldump while using this tool, never (again)
- We identify the mysql process with the command `ps ax | grep[m]ysqld`
- We should only have one process. Write it down for later
- We'll check the files we can recover `sudo lsof -p $MYSQL_PID`
- We can see all the files deleted
- And as long as we have Mysql running, we'll be able to get those files back

# Why it can work

Already, it is necessary to understand how Linux works in ext* when deleting a file.

We're going back to the base. When a process opens a file, it opens an FD "file descriptor" in `lsof`.

A file is defined in the ext* file system as a path that points to an inode.

When you delete a file, you delete this link in the file allocation table.

And ext* frees up the space when an inode no longer has an FD open on the inode.

That's why sometimes you delete a large file, but the space is not cleared.

Or when you make a `mv' of a log file, touch the new file and the process continues to write to the file that has been renamed. The FD is still open on the old inode. It hurts a little bit of a headache, doesn't it?

And so since Mysql keeps the files open, we can make a `cat /proc/$PID/df/9`.

So much for the recovery part of the deleted files.

Now, the stories around `touch`.

This is the part I have less control over, but I can imagine Mysql's behavior.

When doing a `show databases;` Mysql must read the list of directories in `/var/lib/mysql`. That's why you can end up with a `lost+found` database.

Then when we do a `show tables;` Mysql must read the list of files `*.MYI` or `*.MYD` (or both, or when one misses mysql may be crash). So a touch of the files brings up the tables. But since the files are already open, he will be able to access the old deleted files content.

However, a `desc table` or `select` will not work. For this purpose Mysql needs the `*.frm` files that contain the table structure. And here, the `frm/MYD/MYI` files must be properly aligned.

That's it, we only have the Mysqldump that doesn't work. I think he tries to read directly into the content of the files and that the `touch' mess disturbs him.

I'm done with this article. I hope I taught you some things. That you'll never have to put all this into practice on production.

And if I have any advice to give:
- Make backups
- Testing restorations
- Note the time of these operations to be aware of the time it will take in case of a crash
- If you do mysqldump, also think about making regular backups of.frm files
