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

By default, each time your device connects to the internet via Wi-Fi, it asks Google's [captive portal](https://en.wikipedia.org/wiki/Captive_portal) server (`connectivitycheck.gstatic.com`) for a specific response code: `HTTP 204`.
Only if that response code is delivered will your device connect to the internet.

Let's remove Google from this equation.

**Note**: This is one of the weirder de-Googling tweaks.
I always use it together with blocking `connectivitycheck.gstatic.com` (via *AdAway*) to make sure that I catch errors, and this is what I experience:

- Sometimes these tweaks cause the "x" symbol to appear with the Wi-Fi/LTE symbols, and sometimes internet works nevertheless, and sometimes it actually does not.
- Sometimes (?), disabling Captive Portal nullifies the alternative server settings, and vice versa.
- Any setting is reversed after installing an upgrade (see below).

I am still in the process of figuring out how to handle this permanently.
Until then, I recommend disabling Captive Portal check completely and see if it causes any trouble.


### Change Captive Portal settings

From a host machine (connected via USB), execute the following commands with *adb*.

<!-- From a host machine (connected via USB), give yourself root access to the device's shell: -->
<!--  -->
<!-- ``` -->
<!-- $ adb root -->
<!-- $ adb shell -->
<!-- ``` -->
<!--  -->
<!-- Then choose one of the following options: -->


#### Option 1: Provide an alternative Captive Portal server

For example [Kuketz' server](https://www.kuketz-blog.de/empfehlungsecke/#captive-portal):

```
$ adb shell 'settings put global captive_portal_http_url "http://captiveportal.kuketz.de"'
$ adb shell 'settings put global captive_portal_https_url "https://captiveportal.kuketz.de"'
$ adb shell 'settings put global captive_portal_fallback_url "http://captiveportal.kuketz.de"'
$ adb shell 'settings put global captive_portal_other_fallback_urls "http://captiveportal.kuketz.de"'
```

Check respectively with:

```
$ adb shell 'settings get global captive_portal_http_url'
$ adb shell 'settings get global captive_portal_https_url'
$ adb shell 'settings get global captive_portal_fallback_url'
$ adb shell 'settings get global captive_portal_other_fallback_urls'
```

<!-- ```{.shell} -->
<!-- # settings put global captive_portal_http_url "http://captiveportal.kuketz.de" -->
<!-- # settings put global captive_portal_https_url "https://captiveportal.kuketz.de" -->
<!-- # settings put global captive_portal_fallback_url "http://captiveportal.kuketz.de" -->
<!-- # settings put global captive_portal_other_fallback_urls "http://captiveportal.kuketz.de" -->
<!-- ``` -->

Reboot.

<!-- **Note**: These settings seem to revert back to default by themselves after some days (?). -->
<!-- I have not yet figured out what is going on, so make sure to check these settings after some time to make sure they are still enabled. -->


##### Edit *AFWall+* settings

Your *AFWall+* may block the system service responsible for the Captive Portal check.
As a result, your internet connection is disabled by the system.
Do not ask why because only Google knows.

The easiest solution is to just whitelist the service `Dynamic System Updates, Android System, Setup Wizard, [...]`.
This worked for me, but it also allows a range of unrelated services to phone home.

[Kuketz](https://www.kuketz-blog.de/empfehlungsecke/#captive-portal) suggests expanding the custom script with:

```
# IPv4
$IPTABLES -A "afwall" -d 185.163.119.132 -p tcp -j ACCEPT
# IPv6
$IP6TABLES -A "afwall" -d 2a03:4000:3b:3cc:5480:6fff:fec0:ad9f -p tcp -j ACCEPT
```

... though I myself could not make it work (applying the rules throws an error).
Try it out.


#### Option 2: Disable Captive Portal lookup

This option may cause problems with Wi-Fi login forms, but it may be worth a try.

**Note**: After a couple days, this caused my Wi-Fi-connection to be stuck in a "log in to connect" request, indicated by a grey Wi-Fi symbol and the dreaded "x" tag. No idea why. I reverted to option 1.

```
$ adb shell 'settings put global captive_portal_detection_enabled 0'
$ adb shell 'settings put global captive_portal_server localhost'
$ adb shell 'settings put global captive_portal_mode 0'
```

Check respectively with:

```
$ adb shell 'settings get global captive_portal_detection_enabled'
$ adb shell 'settings get global captive_portal_server'
$ adb shell 'settings get global captive_portal_mode'
```

<!-- ``` -->
<!-- # pm disable com.android.captiveportallogin -->
<!-- # settings put global captive_portal_detection_enabled 0 -->
<!-- # settings put global captive_portal_server localhost -->
<!-- # settings put global captive_portal_mode 0 -->
<!-- ``` -->

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

