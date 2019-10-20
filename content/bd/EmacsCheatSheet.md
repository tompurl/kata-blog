+++
title = "Emacs Cheat Sheet"
author = ["Tom Purl"]
date = 2019-10-17
lastmod = 2019-10-19T09:15:31-05:00
tags = ["org", "emacs"]
categories = ["braindump"]
weight = 2001
draft = false
[menu.braindump]
  weight = 2001
  identifier = "emacs-cheat-sheet"
+++

-   State "DONE"       from "TODO"       <span class="timestamp-wrapper"><span class="timestamp">[2019-10-17 Thu 20:51]</span></span>


## Screen navigation {#screen-navigation}

-   Quit
    -   `C-x C-c`
-   Move down a screen
    -   `C-v`
-   Move up a screen
    -   `M-v`
-   forward one char
    -   `C-f`
-   backwards one char
    -   `C-b`
-   up one line
    -   `C-p`
-   down one line
    -   `C-n`
-   forward one word
    -   `M-f`
-   Backwards one word
    -   `M-b`
-   Move to the other window
    -   `C-x o`
-   Move forward one page
    -   `C-v`
-   Move backwards one page
    -   `M-v`
-   Reset page around cursor with it at the center.
    -   `C-l`
-   Move forward one word
    -   `M-f`
-   Move backwards one word
    -   `M-b`
-   Move to the beginning of a line.
    -   `C-a`
-   Move to the beginning of a sentence.
    -   `M-a`
-   Move to the end of a line.
    -   `C-e`
-   Move to the end of a sentence.
    -   `M-e`
-   Move to the beginning of the document
    -   `M-<` - Move
    -   Please note that you also need to press the shift key since `<` is above
        the `,` key.
-   Move to the end of the document
    -   `M->` - Move
-   Show only one window
    -   `C-x 1`
-   Horizontally split the current window
    -   `C-x 2`
-   Vertically split the current window
    -   `C-x 3`

Moving around one line at a time:

```text
                      Previous line, C-p
                              :
                              :
Backward, C-b .... Current cursor position .... Forward, C-f
                              :
                              :
                        Next line, C-n
```


### Emulating Vim's "gg top" Mnemonic {#emulating-vim-s-gg-top-mnemonic}

In Vim when you are in normal mode you can jump to the beginning of a
document by pressing `gg` and the end by pressing `G`. Here are some
keybindings for Emacs that are similar:

```emacs-lisp

(global-set-key (kbd "C-x gg") 'beginning-of-buffer)
(global-set-key (kbd "C-x G")  'end-of-buffer)

```


## Search {#search}

-   Incremental Search
    -   `C-s`
    -   To find the next match just keep pressing `C-s`

-   `M-x replace-string`
    -   Find and replace on every instance of a string from the cursor position to the end of the document.


## File Management {#file-management}

-   Creating a new file
    -   Find it `(C-x C-f)`
    -   Type in the location where you want to save it.
-   Saving a file
    -   `C-x C-s`


### Registers {#registers}

Registers are good for quickly storing and finding all kinds of things, but I
mostly use them to open files that I use a lot. For example, I can put the
following in my `.emacs` file:

```text
; Org index
(set-register ?i (cons 'file "c:/td/gtd/org/index.org"))
; .emacs file
(set-register ?e (cons 'file "~/.emacs"))
```

…and then open the files like this:

`C-x r j i`

`C-x r j e`


### Recovery {#recovery}

To recover a file, open it and then type `M-x recover-file`.


## Text Management {#text-management}


### Misc {#misc}

-   Auto wrap a line by adding a carriage return
    -   Similar to `gqip` in Vim
    -   `M-q`
-   Selecting Text
    -   Simply go to the beginning, press `C-Space` and then navigate to the end
        position.
    -   This is a lot like a visual select in Vim.


### Copying And Pasting With The Kill Ring {#copying-and-pasting-with-the-kill-ring}

`<DEL>` in Emacs parlance means "Backspace", not "Delete". For that,
they use `<DELETE>`.

-   `<DEL>`
    -   Delete the character just before the cursor. Using the `<DEL>` key
        does **not** add the text to the kill ring, so avoid it when you can.
-   `C-d`
    -   Delete the next character after the cursor
-   `M-<DEL>`
    -   Kill the word immediately before the cursor
-   `M-d`
    -   Kill the next word after the cursor
-   `C-k`
    -   Kill from the cursor position to end of line
-   `M-k`
    -   Kill to the end of the current sentence
-   `C-w`
    -   Kill selected text
-   `C-y`
    -   Yanks the last text killed. With Emacs, "yank" means "yank it off
        of the kill ring", **not** "cut" like it does in Vim.  If you kill a
        bunch of text repeatedly, then one yank pastes all of that text
        back.
-   `M-y`
    -   Allows you to "cycle through" your kill ring. If the text retured
        by C-y isn't what you want, jus type this until you see the text
        you want.


### CUA Mode {#cua-mode}

CUA Mode allows you to use C-c and C-v when you have selected text. Here’s more
information:

-   <http://www.emacswiki.org/emacs/CuaMode>

…and here’s what I added to me .emacs file:

```text
(cua-mode t)
(setq cua-auto-tabify-recptangles nil) ;; Don't tabify after rectangle commands
(transient-mark-mode 1) ;; No region when it is not highlighted
(setq cua-keep-region-after-copy t) ;; Standard Windows behavior
```


## Editing Search Buffers {#editing-search-buffers}

One of my favorite features of Emacs is how easy it is to edit the **results** of a
search buffer. Here's how you do that in different scenarios.


### Word Search {#word-search}

TODO


### File Name Search {#file-name-search}

1.  First find the files using `find-name-dired`.
2.  Then use `wdired` to edit the results.


## Scripting {#scripting}


### Interrogating A Variable VAles {#interrogating-a-variable-vales}

If you want to find out the current value of a variable, just type the
following:

```text
C-h v <var name>
```

For example:

```text
C-h v org-agenda-files
```


## Misc {#misc}


### Remove Version Page On Startup {#remove-version-page-on-startup}

```text
; http://askubuntu.com/a/4824
(setq inhibit-startup-screen t)
(add-hook 'emacs-startup-hook
  (lambda () (delete-other-windows)) t)
```


### Change The Default Web Browser {#change-the-default-web-browser}

This is all I had to add to my `.emacs` file on my Windows 7 machine to
start using Firefox instead of IE:

```text
(setq browse-url-browser-function 'browse-url-firefox)
```


### Show Line Numbers {#show-line-numbers}

```text
M-x linum-mode
```


### Toggle Word Wrap {#toggle-word-wrap}

This is similar to the `:set nowrap` command in Vim, except it toggles
the option:

```text

M-x toggle-truncate-lines

```
