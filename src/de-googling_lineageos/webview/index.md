---
title: De-Googling Lineage OS 18.1
subtitle: WebView with *Bromite*
last-update: 03.11.2021
author: David Kaumanns
tags:
  - Privacy
---

[Android WebView ist based on Chromium](https://www.chromium.org/developers/androidwebview).
WebView is a crucial component in Android used by many apps without you noticing it, so it makes sense to make sure it is trustworthy and does not report back to Google.

[Bromite](https://www.bromite.org) is a Chromium fork that promises ad blocking and privacy enhancements over vanilla Chromium.
It is widely recommended to use as WebView backend instead of the system default.

On your host machine, download the latest APK for your device here:

<https://www.bromite.org/system_web_view>

You probably have an ARM or ARM64 architecture on your device.

Rename the file to a more succinct name, e.g. to `bromite.apk` via:

```
mv arm_SystemWebView.apk bromite.apk
```

Make sure that these options are enabled on your device in *Settings -> System -> Advanced -> Developer options*:

- USB debugging
- Rooted debugging

Make sure the device is connected to the host machine.

On your host machine, start ADB as root, remount the root partion on the device and log into the device shell:

```
$ adb root
$ adb remount
$ adb shell
```

On your device, create a directory **with the same name as the APK file** and exit:

```
# mkdir /system/app/bromite
# exit
```

On your host machine, push the APK file to the newly created directory,
and then log back into the device (still within the `adb root session`):

```
$ adb push bromite.apk /system/app/bromite/
$ adb shell
```

On your device, change the access permissions of the file as such:

```
# chmod 644 /system/app/bromite/bromite.apk
```

Reboot the device.

After reboot, check *Settings -> System -> Advanced -> Developer options -> WebView implementation*.
It should now show *Bromite System WebView*.

