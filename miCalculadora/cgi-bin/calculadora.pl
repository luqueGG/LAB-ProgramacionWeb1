#!/usr/bin/perl
use strict;
use warnings;
use CGI;

my $query = CGI->new;
print $query->header('text/html');

my $expression = $query->param('expresion');