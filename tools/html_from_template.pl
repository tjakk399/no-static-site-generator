#!/usr/bin/env -S perl -CA

# The extra flags are needed to decode @ARGS as UTF-8.

use strict;
use utf8;

binmode STDIN, ":encoding(UTF-8)";
binmode STDOUT, ":encoding(UTF-8)";
binmode STDERR, ":encoding(UTF-8)";

if ($#ARGV + 1 != 2) {
  print("Usage: cat <paths to body HTML files> | $0 <path to template HTML> <title>");
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

$template =~ s/\$title\$/$ARGV[1]/;
$template =~ s/\$body\$/$body/;

print($template)

