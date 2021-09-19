---
title: Email Is No Toy -- Use It Safely
author: David Kaumanns
last-update: 13.09.2021
tags:
  - Privacy
---

## ProtonMail's recent embarrassment

[ProtonMail](https://protonmail.com/ ) is an email provider that promises secure and private email communication via encryption.
It has recently complied with a request from Europol through Swiss authorities to submit IP address and device information related to a wanted individual:

<https://twitter.com/tenacioustek/status/1434604102676271106>

Knowing how [PGP encryption works](https://wiki.archlinux.org/title/GnuPG), it is reasonable to assume that law enforcement also got access to another trove of information: email metadata (sender, recipient, subject line, etc.)

This should be irritating to customers of ProtonMail since ProtonMail (used to) explicitly state:

> No personal information is required to create your secure email account. By default, we do not keep any IP logs which can be linked to your anonymous email account. Your privacy comes first.
^[The Register, *ProtonMail deletes 'we don't log your IP' boast from website after French climate activist reportedly arrested*, 07.09.2021, <https://www.theregister.com/2021/09/07/protonmail_hands_user_ip_address_police/>]

... which should imply to any reasonable reader that their service is safe to use for political activists and the likes.

However, it seems that the company exploited/utilized the ambiguity/vagueness of the expression "by default" in order to lure (?) privacy-conscious people to their service.

## Email is not safe

This incident should remind us of a simple fact that is relevant for *all* email providers:
Email is dangerous.
Do not use it for really sensitive communication.

**First**, email is **unencrypted by default** (and for probably almost all of your contacts).
Even if your contacts use PGP, there is a high likelihood that any of your recipients will accidentally reply in clear text and/or quote your previously encrypted message in clear text.

**Second**, even PGP-encrypted emails **leak metadata** left and right:
sender, recipient, subject line, date, everything that is in the header.
The header simply cannot be encrypted.
This is a fundamental flaw of the email protocol itself, so there is no remedy.

But we have to use email.
So what are the best practices to minimize the risk?


## Best practices

**Note**: Below guidelines refer to [Mailbox.org](https://mailbox.org) email provider service as an example, but I do not explicitly endorse it.
I personally trust it (so far), you may not.


### 1. Choose a trustworthy email provider.

Maybe ProtonMail should not deserve your trust, but Gmail et al. *definitely* do not deserve it.

Look for a privacy-first email provider.
**Pay for it.**
There is no such thing as a trustworthy free email provider.

Look for **smaller less-known** services that are less likely to be a [honeypot](https://yewtu.be/watch?v=IeXaYR4ed9c) secretly feeding government authorities with potential dissidents.

Specifically, look for evidence of effort to **reject illegal requests from the police itself**.
For example, [Mailbox.org](https://mailbox.org/en/security) (claims to) employ a dedicated "certified data protection officer".
In 2020, *Mailbox.org* rejected 43 out of 85 illegal requests for information by the authorities, per their [transparency report](https://mailbox.org/en/post/transparency-report-mailbox-org-2020).
Of these, only 20 requests were re-submitted with the proper formal corrections.
In other words, 27% of requests were tried once illegally, and then never again.
Few email providers even claim to protect you from these kinds of unlawful intrusions by the government itself.


### 2. Use PGP/GPG encryption for outgoing and incoming emails.

[Encrypt your messages via PGP/GPG](https://wiki.archlinux.org/title/GnuPG) if and when possible.

Yes, metadata is still open game, but at least your message contents are somewhat safe if you encrypt and decrypt **locally** (i.e. on your client device).

Some email providers (e.g. *Mailbox.org*) allow **encrypting all incoming and outgoing emails** with your public key on their server so only you can read them on your device.
This still technically allows your provider to read and log your contents before they encrypt it.
However, if your provider is trustworthy, using this feature absolves them from the liability of your email contents.


### 3. Use POP3, not IMAP, to delete emails remotely after download.

Make sure that emails never stay long on anyone's server but your own, even if PGP-encrypted.

If you can afford to not synchronize your emails across several clients (or devices), use POP3 to **delete emails** from your provider's server right after download.

If your provider is trustworthy, this absolves them from the liability of your emails, including metadata.

Do not synchronize your "Sent" and "Drafts" folders with the server.

If your toolchain only allows using IMAP, create a local folder for "Seen" emails and move new emails immediately from your inbox.
Obviously, do not synchronize the "Seen" folder with the server.


### 4. Connect to your email provider via VPN or Tor.

Hide your IP address when you can.
No reason to burden your email provider with the liability of your IP address.

Remember that your IP address reveals possibly your identity (if your personal ISP is involved) and definitely your location.


### 5. Do not put sensitive information in the subject line.

In all cases, the subject lines of your emails are public information.
Treat them as such.


### 6. Know that metadata are always public.

This concerns, for instance, sender and recipient email addresses.
Treat as public information when you conversed with whom via email.


### 7. Assume that your contacts are compromised.

This has nothing to do with you not trusting your contacts, but with you being sceptical about their tech stack or abilities.
**If defaults are insecure, you should assume the worst.**
This is the case with the email protocol.

You do not know the **email provider** behind your contact's personal domain.
`joe@schmoe.com` may just point to *Gmail*.
^[I have seen professional tech companies handling their HR business via *Gmail*.]

You have no control over whether even a contact using PGP **replies in plain text**, accidentally, potentially revealing your whole conversation up to that point.

The inherent risks grow exponentially with the **number of recipients**, obviously.


## Conclusion

Email is inherently non-private and unsafe.

Email's defaults are insecure.
Therefore, expect your contacts to (inadvertently) publish your communication.

PGP encryption is strong but rarely used on both sides.
It also does not prevent authorities from eavesdropping on your valuable metadata.

Do not use email in any form if your safety is at stake.

However, for your mandatory email communication, there are better and worse practices, as well as more or less trustworthy email providers.

Choose wisely, and use [modern secure communication protocols](https://www.privacytools.io/software/real-time-communication/) for anything else.
