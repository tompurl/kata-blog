+++
title = "Python Notes"
author = ["Tom Purl"]
date = 2020-02-12T10:18:00-06:00
lastmod = 2020-04-21T12:42:55-05:00
tags = ["python"]
categories = ["braindump"]
weight = 2004
draft = false
[menu.braindump]
  weight = 2004
  identifier = "python-notes"
+++

-   State "DONE"       from "TODO"       <span class="timestamp-wrapper"><span class="timestamp">[2020-02-12 Wed 10:18]</span></span>


## Toolset {#toolset}

-   Emacs
    -   [jedi.el](http://tkf.github.io/emacs-jedi/latest/)
    -   Projectile
    -   [flycheck](https://www.flycheck.org/en/latest/) (for Emacs)
    -   elpy
    -   pipenv.el
-   pytest
-   pipenv
-   Multiple terminal windows for the following helpers:
    -   ipython
    -   git


## Pipenv {#pipenv}


### Rebuilding a virtual environment {#rebuilding-a-virtual-environment}

One of the great things about `pipenv` is that it makes virtual environment
management relatively brainless. For example, here's how I rebuild a "clean"
virtual environment:

```text
# Assuming that you're within the "broken" virtualenv shell
exit
pipenv --rm
pipenv --python <path to python interpreter in your pipfile>
pipenv install
pipenv install --dev
pipenv shell
```


### Creating a New Project {#creating-a-new-project}

Assuming that your project does not **yet** have a Pipfile, here's how I create
one:

```text
pipenv --python <path to preferred python interpreter>
pipenv install --dev pytest jedi autopep8 yapf flake8
```


## Solving PYTHONPATH Issues {#solving-pythonpath}

I had an issue lately where a Python script in a virtualenv was not
using the versions of the libraries that were installed in that
virtualenv. Here's some tips that I learned when debugging the
issue.


### Checking The Instance Of Python Being Executed {#checking-python-instance}

First, are you **sure** that you're running the Python executable
that you think you're running?

The proper version of Python may not be executed just because
you're running a script within virtualenv. This is easy to test by
simply checking the process table. Also, you can try prepending
your script like this:

```sh
python -m your-script.py
```

This was my big mistake the last time I had PYTHONPATH
issues. After checking the version of Python that was running when
I executed my script I noticed that it was from a **completely
different virtualenv**.


### Checking The Loaded Libraries At Runtime {#checking-loaded-libraries-at-runtime}

If you'd like to see what libraries are being loaded and from
where, simply prepend the following to the command that you run to
execute your Python script:

```sh
python -v -m your-script.py
```


### Checking The Library Version In The REPL {#checking-loaded-libraries-in-repl}

Of course, you can also check library versions in the Python REPL
like so:

```sh
python -c "import robot; print(robot.__version__)"
```


## Setting Up A Development Environment On Windows {#windows-dev}

The only tool that changes on Windows is my terminal editor. My
preference is ~~Cmder~~ Fulent Terminal running a Powershell instance.

This works pretty well for me but I learned a few lessons when setting
this up:


### [sniffer](https://github.com/jeffh/sniffer) Isn't Usable on Windows {#sniffer-on-windows}

Sniffer hung for me every time I tried to kill it and it wasn't able to see when
a file was changed, even after I install `pywin32`.

I ended up using [py.test](https://docs.pytest.org/en/latest/) instead and am very happy with the results.


### Jedi's A Little Funny {#funny-jedi}

I've had issues starting the jedi server automatically, so I always
run this command if I'm going to be working on some Python code:

-   `M-x jedi:start-dedicated-server`


## Emacs Setup {#emacs}

`pipenv` has made things a lot easier to configure Emacs as my Python IDE. Here's
my config:

-   <https://github.com/tompurl/dot-emacs/blob/master/emacs-init.org#python>

As long as I'm using `pipenv` and `pipenv.el` then this configuration is pretty
darned automatic.


## TLS Oddities {#tls-oddities}


### Converting an Encrypted Keypair Into Friendly Formats {#converting-an-encrypted-keypair-into-friendly-formats}

If you want to use client-side TLS with the `requests` library then the easiest
way to do that is with an unencrypted keypair, with one file for each key. Easy,
right?

Welllll I tried doing this 10 different ways with my favorite TLS tool Key Store
Explorer but just couldn't find the proper format that the `requests` library
was expecting. Thank goodness I finally found the following:

-   <https://github.com/psf/requests/issues/1573#issuecomment-188125157>

Here's my shamelessly copying and pasting it:


#### Generate certificate and private key. {#generate-certificate-and-private-key-dot}

```text
// Generate the certificate file.
openssl pkcs12 -in /path/to/p12cert -nokeys -out certificate.pem
// Generate private key with passpharse, First enter the password provided with the key and then an arbitrary PEM password //(say: 1234)
openssl pkcs12 -in /path/to/p12cert -nocerts -out privkey.pem
```

Well, we are not done yet and we need to generate the key that doesn't require the
PEM password every time it needs to talk to the server.


#### Generate key without passphrase. {#generate-key-without-passphrase-dot}

```text
// Running this command will prompt for the pem password(1234), on providing which we will obtain the plainkey.pem
openssl rsa -in privkey.pem -out plainkey.pem
```
