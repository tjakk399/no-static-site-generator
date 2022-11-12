# no-static-site-generator

You just want to set up a simple text-based website, maybe a blog with images? Nothing fancy?

You do not want to learn another static site generator framework with weird assumptions and bogus pipelines?

You are able to open the command line and type a few commands?

You know and use [Pandoc](https://pandoc.org/)?

Then this is for you.

---

Tested with:

- Linux, Mac
- GNU Make 4.3 (**NOTE**: MacOS's built-in make does not suffice. You need to install GNU Make as `gmake` and use that instead.)

## Setup

Clone this repository.

Install:

- [Pandoc](https://pandoc.org/)
- pandoc-crossref
- pandoc-include-code
- [Graphviz](https://www.graphviz.org/)
- Java Runtime (for [PlantUML](https://plantuml.com)
- ImageMagick (optional)

Tip: the Pandoc filters can be installed as such:

```
$ pip install pandoc-xnos pandoc-crossref
```

## Usage

The `src` directory contains your static website almost exactly as it will be served by your server, including directory structure, assets and all.

The only difference: Each page is written as a Pandoc file, not as HTML.

### Header YAML

At the top of each Pandoc file you may specify a YAML structure with variables.
These are used to fill the slots in the `TEMPLATE_ARTICLE` HTML template (see below).

Example:

```
---
title: Fancy title
author: Joe Schmoe
tags:
  - Taggy
  - McTagface
---
```

### Compile HTMLs from Pandoc files

This command compiles all Pandoc files in `src` to HTML files, using the specified templates:

```
make site \
    AUTHOR="Arthur McAuthorface" \
    TEMPLATE_ARTICLE=<HTML template for article> \
    TEMPLATE_INDEX=<HTML template for full HTML>
```

1. `TEMPLATE_ARTICLE` wraps the content of the Pandoc file and yields raw HTML markup with `<article>` as the top element, followed by...
2. `TEMPLATE_INDEX`, yielding the complete servable HTML.

The `templates` directory contains default templates.


#### Optional: mark images for conversion to monochrome

This is a feature I implemented in order to save bandwidth from my Raspberry Pi server.
I may package it more neatly in the future.

Until then, let selected original images be converted to monochrome + 600px width by naming their file extensions as such:

```
myfilename.@to-monochrome.png
```

All images thusly named will be converted to monochrome:

```
myfilename.@monochrome.png
```

... which you can refer to e.g. in your Pandoc files.


### Synchronize site with server

Upload your site to a remote destination.
Pandoc source files (and original images, see above) are excluded automatically.

Call:

```
make sync \
    HOST_USER="<my_host_user>" \
    HOST_NAME="<my_host_name>" \
    HOST_DIR="<my_host_dir>" \
    HOST_PORT="<my_host_port_number>" 
```

## License

GPLv3
