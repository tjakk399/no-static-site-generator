---
title: De-Googling Lineage OS 18.1
subtitle: Captive Portal Server
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

By default, each time your device connects to the internet via wifi, it asks Google's [captive portal](https://en.wikipedia.org/wiki/Captive_portal) server (`connectivitycheck.gstatic.com`) for a specific response code: `HTTP 204`.
Only if that response code is delivered will your device connect to the internet.

Let's remove Google from this equation.

From a host machine (connected via USB), give yourself root access to the device's shell:

```
$ adb root
$ adb shell
```

Then choose one of the following options:


### Option 1: Provide an alternative Captive Portal server

For example [Kuketz' server](https://www.kuketz-blog.de/empfehlungsecke/#captive-portal):

```{.shell}
# settings put global captive_portal_http_url "http://captiveportal.kuketz.de"
# settings put global captive_portal_https_url "https://captiveportal.kuketz.de"
# settings put global captive_portal_fallback_url "http://captiveportal.kuketz.de"
# settings put global captive_portal_other_fallback_urls "http://captiveportal.kuketz.de"
```

Reboot.


### Option 2: Disable Captive Portal lookup

This option may cause problems with wifi login forms, but it may be worth a try:

```
# pm disable com.android.captiveportallogin
# settings put global captive_portal_detection_enabled 0
# settings put global captive_portal_server localhost
# settings put global captive_portal_mode 0
```

Reboot.


### Nice to know: how to test the new Captive Portal setting

The */e/ foundation* apparently change the AOSP source code itself in order to control the Captive Portal setting:

- <https://doc.e.foundation/what-s-e#degoogling--ungoogling>
- Whitepaper: <https://e.foundation/wp-content/uploads/2020/09/e-state-of-degooglisation.pdf>

It seems that Android allows (or allowed) a mere change of certain global variables to control the Captive Portal setting:
<https://www.kuketz-blog.de/empfehlungsecke/#captive-portal> (German).

However, these variables are `null` prior to setting it.
(At least they were for me.)
So why should we believe that Android actually respects these global variables?

As noted above, an internet connection will be refused if the expected response code is not delivered.

Using *AdAway* (or any other host blocker), we can verify this behaviour by adding `connectivitycheck.gstatic.com` to the blacklist before changing the global variables:
No more internet connection.

After changing the Captive Portal settings, I observe a successful connection, even though Google's server is blocked.

My best guess is therefore that it works, even though we do not fiddle with the source code as */e/* does.

