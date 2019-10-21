+++
title = "Git Cheatsheet"
author = ["Tom Purl"]
date = 2019-10-18
lastmod = 2019-10-21T11:56:56-05:00
tags = ["git"]
categories = ["braindump"]
weight = 2003
draft = true
[menu.braindump]
  weight = 2003
  identifier = "git-cheatsheet"
+++

## Cheatsheet {#cheatsheet}

-   Reverting changes to modified files
    -   `git reset --hard`
-   Removing a remote branch
    -   `git push origin --delete my-branch`


## Creating A New Remote For A Local Repo {#creating-a-new-remote-for-a-local-repo}

This process is used when:

1.  You have code on your local machine that is in a git repo.
2.  This code is not currently pushed to a remote.
3.  You want to store a remote on a different filesystem (e.g. a
    directory accessible over NFS or SSH).

In this example I'm pushing to a shared Windows drive.

```ps
# Navigate to the location of where you want to store your code.
cd \\some-server\share$\tom\git
git init --bare dotemacs

# Now navigate to your repo and push
cd c:\users\tom\.emacs
git remote add origin '\\some-server\share$\tom\git\dotemacs'
git push --set-upstream origin master
git push origin --mirror
```

Now you can backup your repo to a different server and even share your
code with others who have access to that shared directory.

-   This is a very long line this is a very long line this is a
    very long line this is a


## View Pull Request Diff From The Command Line {#view-pull-request-diff-from-the-command-line}

```sh
cd $project
git checkout $trunk
git pull
git checkout $feature_branch
git pull
git request-pull dev ./
# If you want to see the diff contents add the -b flag
```


## Convincing Git That a File Isn't Binary {#convincing-git-that-a-file-isn-t-binary}

I have an issue occasionally where `git` thinks that some of my text files are
binary. Specifically, this seems to happen frequently with my `requirements.txt`
files. Here's what I've done to fix this.

Please note that this process still seems a bit black-magicky to me. Some of
these steps may not be necessary.

1.  In my repository, create a `.gitattributes` files with the following contents:
    1.  `*.txt text working-tree-encoding=UTF-16LE eol=CRLF`
    2.  I chose this text encoding because it appears to be the default on my
        Windows laptop running emacs.
2.  I set the encoding of my file to `utf-8-dos` in Emacs and saved it.
3.  Commit both files to the `git` repo.
4.  Make another change to the target text file (e.g. `requirements.txt`).

You should now be able to perform a "text" diff on your files.
