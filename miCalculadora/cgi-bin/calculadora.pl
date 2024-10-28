#!/usr/bin/perl
use strict;
use warnings;
use CGI;

my $query = CGI->new;
print $query->header('text/html');
my $expresion = $query->param('expresion');

if ($expresion =~ /^[\d\+\-\*\/\(\)\s]+$/) {
    # Quitar espacios
    $expresion =~ s/\s+//g;

    my @posOrden = cambiarPosFija($expresion);
    my $resultado = evaluarPosOrden(@posOrden);

    print "<h1>Resultado: $resultado</h1>";
} else {
    print "<h1>Formato Denegado.</h1>";
}

# Funcion para convertir una expresion infija a posfija
sub cambiarPosFija {
    my ($expr) = @_; #Parametro de la funcion
    my @salidaExpresion;
    my @operadores;
    my %precedence = ('+' => 1, '-' => 1, '*' => 2, '/' => 2);

    my @pares = split /(\d+|\+|\-|\*|\/|\(|\))/, $expr;
    @pares = grep { $_ ne '' } @pares; # Elimina pares vacios

    foreach my $par (@pares) {
        if ($par =~ /^\d+$/) {
            push @salidaExpresion, $par;
        } elsif ($par =~ /[\+\-\*\/]/) {
            while (@operadores && $operadores[-1] ne '(' && $precedence{$operadores[-1]} >= $precedence{$par}) {
                push @salidaExpresion, pop @operadores;
            }
            push @operadores, $par;
        } elsif ($par eq '(') {
            push @operadores, $par;
        } elsif ($par eq ')') {
            while (@operadores && $operadores[-1] ne '(') {
                push @salidaExpresion, pop @operadores;
            }
            pop @operadores; # Remover '('
        }
    }
    # Agregar operadores restantes
    push @salidaExpresion, reverse @operadores;
    return @salidaExpresion;
}

# Funcion para evaluar la expresion posfija
sub evaluarPosOrden {
    my @exprPos = @_;
    my @resultado;

    foreach my $par (@exprPos) {
        if ($par =~ /^\d+$/) {
            push @resultado, $par;
        } else {
            my $b = pop @resultado;
            my $a = pop @resultado;

            if ($par eq '+') {
                push @resultado, $a + $b;
            } elsif ($par eq '-') {
                push @resultado, $a - $b;
            } elsif ($par eq '*') {
                push @resultado, $a * $b;
            } elsif ($par eq '/') {
                if ($b == 0) {
                    die "Error: Division por cero";
                }
                push @resultado, $a / $b;
            }
        }
    }
    return pop @resultado;
}
