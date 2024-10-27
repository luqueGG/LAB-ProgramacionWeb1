#!/usr/bin/perl
use strict;
use warnings;
use CGI;

my $query = CGI->new;
print $query->header('text/html');

my $expression = $query->param('expresion');
if ($expression =~ /^[\d\+\-\*\/\s]+$/) {
    my $result = eval($expression);
    if ($@) {
        print "<h1>Error: Solo admite sumas, restas, multiplicacion y division (por cero no)</h1>";
    } else {
        print "<h1>Resultado: $result</h1>";
    }
}else {
    print "<h1>Invalido, intente no usar espacios.</h1>";
}