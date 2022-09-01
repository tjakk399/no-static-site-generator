---
title: Rooting LineageOS 18.1  with Magisk
last-update: 13.09.2021
author: David Kaumanns
tags:
  - Minimal Computing
---

Rooting Lineage OS with *Magisk* is necessary if you want to use privacy power apps such as *AdAway* (host blocker) and *AFWall+* (firewall).

It is also slightly weird, which is why I want to summarize the official *Magisk* installation instructions from:

<https://topjohnwu.github.io/Magisk/install.html>

### 1. Install the *Magisk* app

... just like a normal app, e.g. via *F-Droid*. No flashing necessary.

### 2. Check *ramdisk* status of boot partition

by opening the *Magisk* app and checking the *Ramdisk* info field.

Ramdisk availability informs whether to continue with `boot.img` or `recovery.img`. My *Fairphone 2* has ramdisk, so I will assume it below.

**Important**: your device may not have ramdisk, so please check the original installation instructions.

### 3. Retrieve `boot.img` from *LineageOS* image

Check your current *LineageOS* version e.g. by date under *Settings -> Updater*.

Download the zip archive of your current *LineageOS* version to your host machine from:

<https://download.lineageos.org>

Extract it, e.g. like this:

```
$ unzip lineage-18.1-*-nightly-FP2-signed.zip
```

You should find a **`boot.img`** file.

### 4. Connect your device via USB

... and enable *File Transfer* under *Settings -> Connected devices -> USB*.

### 5. Push `boot.img`

... from the host machine to the device:

```
$ adb push boot.img /sdcard/Download/
```

### 6. Patch the `boot.img` on device

... by opening the *Magisk* app and following the install dialog.

Check the name of the output file in the provided log.
Disregard the path shown.
The actual file looks like this:

```
/sdcard/Download/magisk_patched-23000_uNQ1H.img
```

### 7. Pull the **patched `boot.img`**

... back to the host machine, like this:

```
$ adb pull /sdcard/Download/magisk_patched-23000_uNQ1H.img
```

### 8. Reboot the device into fastboot mode

```
$ adb reboot bootloader
```

Wait until the *Fairphone* logo appears.
The device is now in fastboot mode.

### 9. Flash the patched `boot.img`

... onto the device:

```{.bash}
$ sudo fastboot flash boot magisk_patched-23000_*.img
[sudo] password for david:
Sending 'boot' (6974 KB)                           OKAY [  0.313s]
Writing 'boot'                                     OKAY [  0.186s]
Finished. Total time: 0.507s
```

### 10. Reboot the device

```{.bash}
$ sudo fastboot reboot
Rebooting                                          OKAY [  0.000s]
Finished. Total time: 0.050s
```

### 11. Check root status

... in the *Magisk* app.
It should now show a build number under *Installed* instead of *N/A*.

**Notes**:

- In *Magisk*, tap the shield icon in the bottom row to manage superuser permissions for apps.
- You may have to repeat these steps for each system upgrade.
