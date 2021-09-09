#!/bin/bash

[ -z "$1" ] && echo "Usage: $0 <image file>" && exit 1

[ -f "$1" ] || ( echo "Argument \"$1\" must be an existing file." && exit 1 )

# convert lineage_desktop.png -geometry 300x -colorspace gray -colors 16 -normalize out.png

tmp_filepath="/tmp/out.${1##*.}"
bak_filepath="${1%.*}.bak.${1##*.}"

# filename=${1##*/}
# fileext=${1##*.}
# filebase=${filename%.*}

convert "$1" \
  -geometry 600x \
  -monochrome \
  "$tmp_filepath"

mv -i "$1" "$bak_filepath"
mv -i "$tmp_filepath" "$1"

# identify \
#   -format '%xx%y' \
#   -units PixelsPerInch "$1"

# optipng out.png
