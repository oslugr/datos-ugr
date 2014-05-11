#!/usr/bin/env perl

#       CopyRight 2014 Óscar Zafra (oskyar@gmail.com)
#
#       This program is free software: you can redistribute it and/or modify
#       it under the terms of the GNU General Public License as published by
#       the Free Software Foundation, either version 3 of the License, or
#       (at your option) any later version.
#
#       This program is distributed in the hope that it will be useful,
#       but WITHOUT ANY WARRANTY; without even the implied warranty of
#       MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#       GNU General Public License for more details.
#
#       You should have received a copy of the GNU General Public License
#       along with this program.  If not, see <http://www.gnu.org/licenses/>.

#Versión 1 - Descarga los archivos .xls de la página, los pasa a csv y divide las tablas.

#Para ejecutar este programa hay que instalar las librerías, JSON, File::Slurp, LWP::Simple, URI::http
#Módulo para pasar de xls a csv http://search.cpan.org/~ken/xls2csv/script/xls2csv

use File::Slurp qw(read_file);
use File::Path qw(mkpath);
use LWP::Simple;
use Web::Scraper;
use Spreadsheet::ParseExcel qw(worksheet );
use Spreadsheet::ParseExcel::Workbook qw(get_name);
use v5.014;
use strict;
use warnings;
use YAML qw(LoadFile);

my $workbook;
my $parser  = Spreadsheet::ParseExcel->new();

my @variables = LoadFile('./retribucionesFromXlsToCsv.yml');

# URL para hacer scraping    
my $urlToScrape = $variables[0]->{'urlToScrape'};

# Preparamos los datos
my $teamsdata = scraper {
    # Guardaremos el enlace de las url que tengan esta estructura
    process "div#contenido > div > ul > li > div > a", 'urls[]' => '@href';
    # Guardaremos el texto que hay en las URL dentro de esta estructura
    process "div#contenido > div > ul > li > div > a", 'teams[]' => 'TEXT';
};

# "Scrapeando" los datos
my $res = $teamsdata->scrape(URI->new($urlToScrape));
mkpath("csv");
for my $i (0 .. $#{$res->{'teams'}}) {
    # Hash con el texto que acompaña a la URL y la URL {texto, url}
    my $name = $res->{'teams'}[$i];
    $name =~ s/(^ )|( $)//g;
    #my $url = $res->{'urls'}[$i];
    #$hashUrls{$name} = $url;
    #print readlink($res->{'urls'}[$i]);
    # Me descargo los archivos de los enlaces que se han guardado.
    my $code = getstore($res->{urls}[$i],"$name.xls");
    my $workbook = $parser->parse("$name.xls");
    if ( !defined $workbook ){
      print "ERROR: ".$parser->error(), " \[$name\]\n";
    }else{
      print "\n\n$name.xls\n\n";
      splitTables("$name", $workbook);
    }
}


    #Para imprimir el hash en caso de necesitarlo
    #while ((my $texto,my $url) = each %hashUrls){
    #    print "$texto = $url\n";
    #}


    #open(O, ">out26.txt");
    #my $content = get($url);
    #say ($content=~ /[\w\d\.\_]+\/%21/g);

    #say O $content;


sub splitTables{
    #xls2csv -x $1 -b WINDOWS-1252 -c "$1.csv" -a UTF-8 -f;
    #print "\n\nARGUMENTO   ".$1."\n\n";
    #my $command = " xls2csv -x \"$_[1].xls\" -b ISO-8859-1 -c csv/$_[1].csv -a ISO-8859-1 -f";
    my $command = " xls2csv -x \"$_[0].xls\" -b ISO-8859-1 -c csv/\"$_[0].csv\" -a ISO-8859-1 -f";
    system($command);
    if ($?) {
      print "[ERROR] command failed: $!\n";
      print "[ERROR] No se ha podido ejecutar el comando para la entrada \"$1\" y la salida: \"$1.csv\"\n";
    }
}
