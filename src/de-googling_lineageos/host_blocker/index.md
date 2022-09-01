---
title: De-Googling Lineage OS 18.1
subtitle: Domain Name Blocking with *AdAway*
last-update: 09.09.2021
author: David Kaumanns
tags:
  - Privacy
---

**Requirements**:

- Rooted system

---

![AdAway on Lineage OS](lineage_adaway.@monochrome.png)

System-level blocking of DNS lookup via `/etc/hosts`/ allows system-wide control over all the system's connection requests, including those of apps.
That includes control over apps' pings to trackers, analytics, ad servers etc.
It is a good idea to at least block the most widely known bad actors.

[AdAway](https://f-droid.org/en/packages/org.adaway/) is the app to go.
Given root access, you can configure it to your desire, e.g. by enabling and adding block lists.

It makes sense to install an anti-Google blocklist, such as <https://raw.githubusercontent.com/jmdugan/blocklists/master/corporations/google/all>.
Add the raw link to the list of hosts sources.

Plus, **after you performed the de-Googling changes in the other sections of this guide**, you may want to make sure that the original target URLs are never reachable.
Adding them to the blacklist:

```
north-america.pool.ntp.org
supl.google.com
connectivitycheck.gstatic.com
time.android.com
```
