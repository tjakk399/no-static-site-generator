---
title: De-Googling Lineage OS 18.1
subtitle: High-Level System Settings
last-update: 09.09.2021
author: David Kaumanns
tags:
  - Privacy
---

**Requirements**: None.


## Change system browser defaults

![Lineage OS browser settings](lineage_browser.@monochrome.png)

Change these settings in the default browser:

- Search engine
- Suggestions provider
- Homepage (e.g. to `http://somedummyurl`)


## Disable phone number lookup

![Lineage OS phone number lookup settings](lineage_phone.@monochrome.png)

Unless you are comfortable sending your contacts' phone numbers to a bunch of third parties (including Google), disable all lookup options in:

*Phone app -> Settings -> Phone number lookup*


## Change the Domain Name Server (DNS)

![Lineage OS DNS setting](lineage_settings_dns.@monochrome.png)

Lineage OS's DNS server setting is controlled by Google by default.

If you care about not allowing Google to snoop on all your device's DNS lookups, change the *DNS-over-TLS (DoT)* provider in

*System Settings -> Network & Internet -> Advanced -> Private DNS*.

I chose the first recommendation from here: <https://www.kuketz-blog.de/empfehlungsecke/#dns>.
