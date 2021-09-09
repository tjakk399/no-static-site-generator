---
title: De-Googling Lineage OS 18.1
subtitle: SUPL for A-GPS
last-update: 09.09.2021
author: David Kaumanns
tags:
  - Privacy
---

**Requirements**:

- Rooted system
- Ability to open the command line on a \*nix machine.
- Android Debuge Bridge (ADB) set up on a host machine
- Device connected to that host machine

---

From a handy (Reddit post)[https://www.reddit.com/r/LineageOS/comments/cl5c90/degoogling_lineageos_instructions_august_2019/]:

> LineageOS defaults to `supl.google.com` for SUPL data, which helps in speeding up device positioning (aka TTFF) when using A-GPS, but each request to server is accompanied by device's IMEI.

In other words, each time your device requests its GPS position, it sends a unique identifier to Google's servers along with its location.

If you are willing to trade quick GPS positioning for privacy, follow the steps below.

On your host machine, restart `adb` as root:

```
$ adb root
```

Re-mount root as read-write:

```
$ adb shell mount -o rw,remount /
```

Log into the device shell:

```
$ adb shell
```

Open the GPS configuration file for editing:

```
$ nano /etc/gps.conf
```

Now change some entries.

You may want to change `NTP_SERVER` to a European one:

```
NTP_SERVER=europe.pool.ntp.org
```

Change `SUPL_HOST` from the Google default to localhost:

```
SUPL_HOST=localhost
```

Leave the `SUPL_PORT` entry untouched, whether it is commented out or not.

Save and close the editor by pressing `CTRL+X` and `Y`.

Exit back on the host machine and re-mount root as read-only:

```
$ adb shell mount -o ro,remount /
```

Reboot your device, e.g. via:

```
$ adb reboot
```

**NOTE**: After some months, I found this setting to be reset to default. My best guess is that some system update overwrote the configuration file.

For more information about the privacy aspects of A-GPS, refer to:

- <https://blog.wirelessmoves.com/2014/08/supl-reveals-my-identity-and-location-to-google.html>
- (German) <https://www.kuketz-blog.de/android-imsi-leaking-bei-gps-positionsbestimmung/>


<!--  -->
<!-- ``` -->
<!-- $ adb pull /system/etc/gps.conf -->
<!-- ``` -->
<!--  -->
<!--  -->
<!-- The edited `gps.conf` has to be copied from your host system back to `/system/etc/gps.conf`, somehow. -->
<!--  -->
<!-- *TWRP* does not seem to be able to decrypt an encrypted `/sdcard/` system storage (PIN-protected), at least through version *3.5.2* (does not accept PIN as decryption key). -->
<!-- That means it is not possible to push the file to user-writable `/sdcard/` and then use TWRP to move it under root-writable `/system/` because *TWRP* cannot read `/sdcard/`. -->
<!--  -->
<!-- ### Case 1: Device is not encrypted -->
<!--  -->
<!-- If your device is not encrypted, you can just push the file to the user-writable `/sdcard/` system storage, like so: -->
<!--  -->
<!-- ``` -->
<!-- $ adb push gps.conf /sdcard/gps.conf -->
<!-- ``` -->
<!--  -->
<!-- ... and then reboot into *TWRP* and move the file to its proper place at root-writable `/system/etc/gps.conf` via *Advanced -> File Manager*. -->
<!--  -->
<!-- ### Case 2: Device is encrypted -->
<!--  -->
<!-- If there is a user-writable section outside `/sdcard/`, you can use that to `adb push`. I could not find it. -->
<!-- So I chose these steps: -->
<!--  -->
<!-- 1. Copy `gps.conf` to external SD card. -->
<!-- 2. Put external SD card into device and reboot into *TWRP*. -->
<!-- 3. Move the file to `/system/etc/gps.conf` via *Advanced -> File Manager*. -->
