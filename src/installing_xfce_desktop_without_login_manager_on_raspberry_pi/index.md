---
title: Installing XFCE Desktop Without Login Manager on Raspberry Pi
last-update: 11.03.2020
author: David Kaumanns
tags:
  - Linux
---

## Introduction

If you intend to use the Raspberry Pi mainly in headless mode and only sometimes in desktop mode, prevent unnecessary CPU and RAM usage by booting into the terminal by default.

This guide shows how to install XFCE desktop for this purpose.
Refer to the source documentation for more information and other desktop environments
^[<https://www.raspberrypi.org/forums/viewtopic.php?t=133691>].

Tested on:

- Raspberry Pi 4 running Raspbian Buster Lite (without desktop)

## Steps

A normal XFCE desktop installation requires these four components

1. Display Server: *Xorg*
2. Desktop Environment: *XFCE*
3. Window Manager: *XFWM*
4. Login Manager: *LightDM*

Install 1 to 3:

```
sudo apt-get install --no-install-recommends xserver-xorg xinit
sudo apt-get install xfce4 xfce4-terminal
```

*LightDM* is installed and enabled by default, so disable it:

```
sudo systemctl disable lightdm.service
```

Start the desktop:

```
startx
```

## Tweaks

If you see unused black borders around your screen, edit `/etc/config.txt` to reflect this entry:

```
disable_overscan=1
```
