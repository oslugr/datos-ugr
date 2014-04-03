#!/usr/bin/env perl

#Versión 1 - Descarga los archivos .xls de la página, los pasa a csv y divide las tablas.

#Para ejecutar este programa hay que instalar las librerías, JSON, Slurp, Switch y Simple

use File::Slurp qw(read_file);
use File::Path qw(mkpath);
use LWP::Simple;
use Web::Scraper;


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
my %urls;



#Programa
principal();


#Métodos
sub principal {
    # URL para hacer scraping    
    my $urlToScrape = "http://gerencia.ugr.es/habilitacion/pages/legislacion/tabla_retribuciones";
    # Preparamos los datos
    my $teamsdata = scraper {
        # Guardaremos el enlace de las url
        process "div#contenido > div > ul > li > div > a", 'urls[]' => '@href';
        # Guardaremos el texto que hay en las URL
        process "div#contenido > div > ul > li > div > a", 'teams[]' => 'TEXT';
    };

    # "Scrapeando" los datos
    my $res = $teamsdata->scrape(URI->new($urlToScrape));  

    # Hash con el texto que acompaña a la URL y la URL {texto, url}
    for my $i (0 .. $#{$res->{teams}}) {
        $urls{$res->{teams}[$i]} = $res->{urls}[$i];
#        say $res->{teams}[$i];
#        say $res->{urls}[$i];
#        print "\n";
     #   print FILE $res->{teams}[$i];
     #   print FILE "\n";
    }

    #open(O, ">out26.txt");
    #my $content = get($url);
    #say ($content=~ /[\w\d\.\_]+\/%21/g);

    #say O $content;


     
}