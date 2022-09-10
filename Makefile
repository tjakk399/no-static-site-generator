################################################################################
# Configuration

SHELL = bash

# Binaries
PERL ?= /usr/bin/perl
SHELL ?= /bin/bash
RSYNC ?= /usr/bin/rsync
PANDOC ?= pandoc

.SECONDEXPANSION:

vpath %.template.html templates/

################################################################################
# Constants

BIBTEX = src/literature.bib

# HTML templates
TEMPLATE_ARTICLE = article.template.html
TEMPLATE_INDEX = index.template.html

# Remote directory for sync
HOST_USER = my_host_user
HOST_NAME = my_host_name.tld
HOST_DIR = my_host_dir
HOST_PORT = 22

DESTINATION = $(HOST_USER)@$(HOST_NAME):$(HOST_DIR)

DIR_SOURCE = src/
EXT_SOURCE = md

RSYNC_EXCLUDES = *.$(EXT_SOURCE)

AUTHOR = Arthur McAuthorface
UPDATED = $(shell date +"%Y-%m-%d")

################################################################################
# Includes

include plugins/image_converter.mk

################################################################################
# Functions

html_from_body = tools/html_from_template.pl $(1)

url = $(notdir $(basename $(1))).html

NUMBER_SECTIONS ?=

define body_from_markdown =
endef

title_key_from_text_file = $(shell cat "$1" | grep "title:" | perl -ne 'chomp; s/"/\\"/g; /title:\s*(.*)$$/; print $$1')

################################################################################
# Definitions

source_files = $(shell find $(DIR_SOURCE) -name '*.$(EXT_SOURCE)')
target_files = $(patsubst %.$(EXT_SOURCE),%.html,$(source_files))

source_images_monochrome = $(shell find $(DIR_SOURCE) -regex '$(REGEX_IMAGES_MONOCHROME)')
target_images_monochrome = $(subst @$(ATTR_MARK),@,$(source_images_monochrome))

################################################################################
# Recipes

.PHONY: default clean site sync

default: site

# Compile site.
site: $(target_files) $(target_images_monochrome)

src/favicon.ico: src/logo.png
	magick -density 128x128 -background none $< -resize 128x128 $@

# Synchronize local with remote.
sync:
	$(RSYNC) \
		--delete \
		--verbose \
		--compress \
		--recursive \
		-e 'ssh -p $(HOST_PORT)' \
		$(foreach exclude,$(RSYNC_EXCLUDES),--exclude '$(exclude)') \
		$(DIR_SOURCE) \
		$(DESTINATION)

# Convert Pandoc/Markdown files to full HTML each.
%.html: %.$(EXT_SOURCE) $(TEMPLATE_INDEX) Makefile $(BIBTEX) tools/anchor-links.lua $(wildcard templates/*.html)
	cat $< \
		| $(PANDOC) \
			--from markdown \
			--to html \
			--standalone \
			--template $(word 2, $^) \
			--variable=author:"$(AUTHOR)" \
			--variable=updated:"$(UPDATED)" \
			--metadata=autoEqnLabels \
			--metadata=link-citations \
			--metadata=link-bibliography \
			--highlight-style src/solarizeddark.theme \
			--mathjax \
			--section-divs \
			--table-of-contents \
			--email-obfuscation=references \
			--filter pandoc-xnos \
			--filter pandoc-crossref \
			--filter pandoc-include-code \
			--metadata=base:src/algorithms_and_complexities
			--citeproc \
			--bibliography src/literature.bib \
			--lua-filter ./tools/anchor-links.lua \
			$(if $(NUMBER_SECTIONS),--number-sections --number-offset 1) \
		> $@
