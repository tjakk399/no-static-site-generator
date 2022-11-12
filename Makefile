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

default: site

################################################################################
# CPP

CPP_SOURCE_FILES = $(shell find src -name "*.cpp")
CPP_OUT_FILES = $(CPP_SOURCE_FILES:%.cpp=%.out)

cpp: $(CPP_OUT_FILES)

%.out: %.cpp
	clang++ -Wall -std=c++20 $< -o $@

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

RSYNC_EXCLUDES = *.$(EXT_SOURCE) *.dot *.uml.txt *.out

AUTHOR = Arthur McAuthorface
UPDATED = $(shell date +"%Y-%m-%d")

DIAGRAM_SRCS = $(shell find src -name "*.dot")
DIAGRAMS = $(DIAGRAM_SRCS:%.dot=%.png)

UML_SRCS = $(shell find src -name "*.uml.txt")
UMLS = $(UML_SRCS:%.uml.txt=%.png)

PLANTUML = tools/plantuml.jar

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

images: $(DIAGRAMS) $(UMLS)

# Compile site.
site: $(target_files) $(target_images_monochrome) $(DIAGRAMS) $(UMLS) $(CPP_OUT_FILES)

src/favicon.ico: src/logo.png
	magick -density 128x128 -background none $< -resize 128x128 $@

# Graphviz
%.png: %.dot
	dot \
		-Tpng \
		$< \
		-o $@

# PlantUML
%.png: %.uml.txt $(PLANTUML)
	mkdir -p $(shell dirname $@)
	cat $< \
		| java \
			-jar $(PLANTUML) \
			-tpng \
			-pipe \
		> $@

$(PLANTUML):
	mkdir -p $(shell dirname $@)
	wget http://sourceforge.net/projects/plantuml/files/plantuml.jar/download -O $@

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
			--metadata=linkReferences \
			--metadata=numberSections \
			--metadata=link-citations \
			--metadata=link-bibliography \
			--highlight-style src/solarizeddark.theme \
			--mathjax \
			--section-divs \
			--table-of-contents \
			--toc-depth 3 \
			--email-obfuscation=references \
			--filter pandoc-crossref \
			--filter pandoc-include-code \
			--citeproc \
			--bibliography src/literature.bib \
			--lua-filter ./tools/anchor-links.lua \
			--shift-heading-level-by=-1 \
			$(if $(NUMBER_SECTIONS),--number-sections --number-offset 0) \
		> $@
