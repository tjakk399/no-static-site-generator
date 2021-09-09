---
title: De-Googling Lineage OS 18.1
subtitle: Network Time Protocol (NTP) Server
last-update: 09.09.2021
author: David Kaumanns
tags:
  - Privacy
---

**Requirements**:

- Ability to open the command line on a \*nix machine.
- Android Debuge Bridge (ADB) set up on a host machine
- Device connected to that host machine

---

The */e/ foundation* states that the Network Time Protocol (NTP) server is set to `time.android.com` on Lineage OS per default.
See:

- <https://doc.e.foundation/what-s-e#degoogling--ungoogling>
- Whitepaper: <https://e.foundation/wp-content/uploads/2020/09/e-state-of-degooglisation.pdf>

I could not verify this claim via `grep -Rl / -e 'time.android.com' 2>/dev/null` as root on the device
which leads me to believe that this setting moved into AOSP source code.

According to (this fella)[https://gist.github.com/xujiaao/63cb3bbea9fe22e79206e5eb7ba82d0e] on Github,
the NTP server on an unspecified version of *Android Things* can be changed by setting a global variable.
For me, this variable was `null` prior to setting it, so there is no indication Android actually respects this variable.

If you want to give it a whirl, run these commands on a host machine with the device connected via USB:
I chose an alternative NTP server from <https://www.ntppool.org>:

```
$ adb shell 'settings put global ntp_server 2.europe.pool.ntp.org'
```

Check

```
$ adb shell 'settings get global ntp_server'
```

