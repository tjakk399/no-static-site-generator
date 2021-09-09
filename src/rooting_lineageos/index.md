---
title: Rooting Lineage OS 18.1 on Fairphone 2 with Magisk
last-update: 05.09.2021
author: David Kaumanns
tags:
  - Linux
---

Rooting Lineage OS with *Magisk* is necessary if you want to use privacy power apps such as *AdAway* (host blocker) and *AFWall+* (firewall).

It is also slightly weird, which is why I want to summarize the official [*Magisk* installation instructions](https://topjohnwu.github.io/Magisk/install.html):

1. Install the *Magisk* app just like a normal app, e.g. via *F-Droid*. No flashing necessary.

2. Open *Magisk* and check whether your device has **ramdisk** in the boot partition (via "Ramdisk" info).

Ramdisk availability informs whether to continue with `boot.img` or `recovery.img`. My *Fairphone 2* has ramdisk, so I will assume it below.

**Important**: your device may not have ramdisk, so please check the original installation instructions.

3. Download the zip of your current [Lineage OS](https://download.lineageos.org/) version to your host machine and extract it. You should find a **`boot.img`** file.

4. Copy the `boot.img` file to your device:

```
adb push boot.img /sdcard/Download/
```

5. Open *Magisk* and patch the `boot.img` file via the install dialog.

6. Copy the **patched `boot.img`** back to the host machine, like this:

```
pull /sdcard/Download/magisk_patched-23000_iXpIR.img
```

7. Reboot the device into fastboot mode:

```
adb reboot bootloader
```

8. Flash the patched `boot.img` onto the device:

```
sudo fastboot flash boot magisk_patched-23000_iXpIR.img
```

9. Reboot the device:

```
sudo fastboot reboot
```

Your device should now be rooted.

**Note**: In *Magisk*, tap the shield icon in the bottom row to manage superuser permissions for apps.
