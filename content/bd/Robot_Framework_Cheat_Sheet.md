+++
title = "Robot Framework Cheat Sheet"
author = ["Tom Purl"]
date = 2019-10-18
lastmod = 2019-10-21T12:20:20-05:00
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
