#!/usr/bin/env perl

use strict;
use utf8;

binmode STDIN, ":encoding(UTF-8)";
binmode STDOUT, ":encoding(UTF-8)";

if ($#ARGV + 1 != 1) {
  print("Usage: cat <body HTML files> | $0 <template HTML>");
  exit(1)
  }

# Read body HTML from STDIN.
my $body = do {
  local $/;
  <STDIN>;
  };

# Read template HTML from file.
open my $fh, "<:encoding(UTF-8)", $ARGV[0];
my $template = do {
  local $/;
  <$fh>;
  };

$template =~ s/\$body\$/$body/;

print($template)

