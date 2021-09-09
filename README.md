# no-static-site-generator

You just want to set up a simple text-based website, maybe a blog with images? Nothing fancy?

You do not want to learn another static site generator framework with weird assumptions and bogus pipelines?

You are able to open the command line and type a few commands?

You know and use [Pandoc](https://pandoc.org/)?

Then this is for you.

## Setup

Clone repository.

Install:

- [Pandoc](https://pandoc.org/)

## Usage

The `src` directory contains your website almost exactly as it will be served by your server, including directory structure, assets and all.

The only difference: Each article is written as a Pandoc file, not as HTML.

### Header YAML

At the top of each Pandoc file you may specify a YAML structure with variables.
These are used to fill the slots in the `TEMPLATE_ARTICLE` HTML template (see below).

Example:

```
---
title: De-Googling Lineage OS 18.1 on Fairphone 2
last-update: 20.07.2021
author: David Kaumanns
keywords:
    - development
    - lineageos
    - privacy
---
```

### Compile HTMLs from Pandoc files

This command compiles all Pandoc files in `src` to HTML files, using the specified templates:

```
make site TEMPLATE_ARTICLE=<HTML template for article> TEMPLATE_INDEX=<HTML template for full HTML>
```

1. `TEMPLATE_ARTICLE` wraps the content of the Pandoc file and yields raw HTML markup with `<article>` as the top element, followed by...
2. `TEMPLATE_INDEX`, yielding the complete servable HTML.

Look into the `templates` directory for example templates.
They are used as defaults.

### Synchronize site with server

```
make sync DESTINATION=<URL>
```

`DESTINATION` may point to your Raspberry, for instance. Like so:

```
make sync DESTINATION=pi@192.168.178.39:/var/www/html/kaumanns.io
```

## License

GPLv3
