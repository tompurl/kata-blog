+++
title = "Robot Framework Cheat Sheet"
author = ["Tom Purl"]
date = 2019-10-18
lastmod = 2020-04-21T12:42:53-05:00
tags = ["emacs", "robot-framework"]
categories = ["braindump"]
weight = 2002
draft = false
[menu.braindump]
  weight = 2002
  identifier = "robot-framework-cheat-sheet"
+++

## Emacs {#emacs}

Make sure that you create a ctags/etags file so you can use the [robot-mode-find-kw](robot-mode-find-kw)
function to jump to a keyword's definition.

On windows, I had the best luck with the Universal Ctags executable. Here's the
command that I use at my project's root to generate my tags file for Emacs:

```sh
cd project-root
ctags.exe -e --langmap="Robot:.robot.txt" -R
```


## Debugging {#debugging}


### General {#general}

This is an excellent reference:

-   <https://docs.plone.org/external/plone.app.robotframework/docs/source/debugging.html>


### Dumping All Variable Values {#dumping-all-variable-values}

Use the following keyword to dump all of the existing variables:

-   `Log Variables    level=INFO`

Please note that the `level` is VERY important. Just choose INFO and you'll see
everything you care about.


## Docker-Related Helpers {#docker-related-helpers}

This is an excellent tutorial on using Docker with the Robot Framework:

-   <https://medium.com/@ypasmk/robot-framework-with-docker-in-less-than-10-minutes-7b86df769c22>

This is really more Chrome and Docker related than Robot Framework related, but
this is a very promising technique for visually troubleshooting a Robot Framework
job that is a) driving a web browser and b) running in a Docker container.

First start your Docker container that contains Chrome using a command that looks
something like this:

```shell
docker run --rm -it -p 9222:9222 -v /home/tom/git/robot-code:/home/jenkins/code --entrypoint bash foo/some-chrome-image
```

Once you're using the container's interactive shell run this command:

```shell
/usr/bin/google-chrome \
    --disable-gpu --headless --no-sandbox \
    --remote-debugging-address=0.0.0.0 \
    --remote-debugging-port=9222
```

Then, on the host machine, visit the following URL in Chrome or Firfox:

-   <http://localhost:9222>

... and then click on the `about:blank` link.

You can now see a "window" into the browser running within the container.

Again, this doesn't have enough wiring to work with Robot Framework yet. That's
something I still need to figure out. But what I'm **hoping** is that I'll figure
out a way to watch my Robot Framework tests in a browser while they're running
withing a Docker container.
