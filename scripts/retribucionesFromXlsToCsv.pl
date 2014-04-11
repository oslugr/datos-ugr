#!/usr/bin/perl

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

#!/usr/bin/env perl

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
use Switch;
use utf8;
use open 'locale'; 
my $file_json;
my $tabla;
my $linea;
my $matriculacion;
use constant false => 0;
use constant true  => 1;
my %hashUrls;
my $content;
my $parser;
my $workbook;

#Programa
principal();


#Métodos
sub principal {
    $parser  = Spreadsheet::ParseExcel->new();

    # URL para hacer scraping    
    my $urlToScrape = "http://gerencia.ugr.es/habilitacion/pages/legislacion/tabla_retribuciones";
    # Preparamos los datos
    my $teamsdata = scraper {
        # Guardaremos el enlace de las url que tengan esta estructura
        process "div#contenido > div > ul > li > div > a", 'urls[]' => '@href';
        # Guardaremos el texto que hay en las URL dentro de esta estructura
        process "div#contenido > div > ul > li > div > a", 'teams[]' => 'TEXT';
    };

    # "Scrapeando" los datos
    my $res = $teamsdata->scrape(URI->new($urlToScrape));

    for my $i (0 .. $#{$res->{'teams'}}) {
        # Hash con el texto que acompaña a la URL y la URL {texto, url}
        my $name = $res->{'teams'}[$i];
	    $name =~ s/(^ )|( $)//g;
        #my $url = $res->{'urls'}[$i];
        #$hashUrls{$name} = $url;
        print readlink($res->{'urls'}[$i]);
        # Me descargo los archivos de los enlaces que se han guardado.
        my $code = getstore($res->{urls}[$i],"$name.xls");
        $workbook = $parser->parse("$name.xls");
        if ( !defined $workbook ){
            print "ERROR: ".$parser->error(), " \[$name\]\n";
        }else{
            splitTables("$name.xls", $workbook);            
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

}

sub splitTables{
    xls2csv -x "1252spreadsheet.xls" -b WINDOWS-1252 -c "ut8csvfile.csv" -a UTF-8;
    
}