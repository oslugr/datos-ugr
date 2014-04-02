#!/usr/bin/env perl

#Versión 1 - Descarga los archivos .xls de la página, los pasa a csv y divide las tablas.

#Para ejecutar este programa hay que instalar las librerías, JSON, Slurp y Switch

use File::Slurp qw(read_file);
use File::Path qw(mkpath);


use v5.014;

use strict;
use Switch;
use utf8;
use open 'locale'; 
my $file_json;
my $tabla;
my $linea;
my $matriculacion;
use constant false => 0;
use constant true  => 1;



#Programa
principal();


#Métodos
sub principal {
    while (@ARGV) {
        
    }
}