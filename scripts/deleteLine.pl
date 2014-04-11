#!/usr/bin/env perl

#Versión 1 - Elimina una linea/s o columna/s que quieras de un archivo CSV.

# Para ejecutar este programa hay que instalar las librerías: File::Slurp, LWP::Simple, Text::CSV
# Script que elimina o una fila o una columna de un archivo CSV

use File::Path qw(mkpath);
use Text::CSV;
use v5.014;
use strict;
use utf8;
use open 'locale'; 

my @inFiles;
my $line;
my $numLine;
#Programa
principal();


#Métodos
sub principal {

    #Se guardan los argumentos que empiezan por csv en un array
    if(scalar(@ARGV) > 2){
        while ($ARGV[0] =~ /([\w\d]*\.[cC][sS][vV]$)/){
            push @inFiles, shift @ARGV;
        }
        if(scalar(@ARGV) >= 2){
            $line = shift @ARGV;
            $numLine = int(shift @ARGV);
        }else{
            if(scalar(@ARGV)!=0){
                print "ERROR: no ha introducido los parámetros correctos\n";
                error();
                exit(0);
            }
        }
        if(scalar(@inFiles) == 0){
            print "Error: No ha introducido ningún argumento de tipo archivo.csv\n";
            error();
            exit(0);
        }
    }else{
        print "\n$0\nExtrae solo las líneas que casan con los parámetros pasados como argumentos y lo pasa a CSV\n";
        print "FORMATO: " . $0 . " Archivo_entrada <Posicion_Inicial Desplazamiento Valor>\n\n";
        error();
        exit(0);
    }
    
    foreach my $in (@inFiles){
        # Creamos instancia de CSV
        my $csv = Text::CSV->new ( { binary => 1, 
            quote_char          => '"',
            escape_char         => '',
            always_quote        => 0,
            eol => $/ } )  # should set binary attribute.
            or die "Cannot use CSV: ".Text::CSV->error_diag ();
        
        #Creamos el manejador de entrada
        open my $inHandler, "<:encoding(utf8)", "$in" or die "$in: $!";
        #Creamos una carpeta para el archivo modificado.
        mkpath("modificado");
        #Creamos el archivo y lo guardamos dentro de la carpeta
        open my $outHandler, ">:encoding(utf8)", "modificado/$in" or die "modificado/$in";
        #my @rows;
        if ( "col" eq $line ){
            #Ordenamos los números de líneas de mayor a menor.
            my @sortedNumLines = sort {$a <= $b}@ARGV;
            while ( my $row = $csv->getline( $inHandler ) ) {
                for( my $i=0; $i < scalar(@sortedNumLines);$i++){
                    splice($row,$sortedNumLines[$i],1);
                }
                $csv->print ($outHandler,$row);
            }
        }else{
            #Ordenamos los números de líneas de menor a mayor.
            my @sortedNumLines = sort {$a >= $b}@ARGV;
            if( "fil" eq $line){
                my $cont=0;

                while (my $row = $csv->getline( $inHandler )){
                    #Se le resta 1 al número de linea
                    if($cont != ($numLine -1)){
                        $csv->print ($outHandler,$row);
                    }else{
                        if(scalar(@ARGV) >0){
                            $numLine = int(shift @ARGV);
                        }
                    }
                    #Sumamos uno en el contador de líneas.
                    $cont++;    
                }
            }else{
                say "ERROR: $line es un argumento inválido";
                say "SUGERENCIA: Escriba fil ó col en lugar de $line";
                say "ó";
                error();
                exit(-1); 
            }
        }
        close($outHandler);
        close($inHandler);
    }
}

sub error{
    say "Ejecuta: perl deleteLine.pl archivo.csv [fil|col] (line/s)";
    say "|--Ejemplo: perl deleteLine.pl archivo.csv fil 1 4 5";
    say "|--Ejecución: Borrará las filas 1, 4 y 5 de archivo.csv";
}