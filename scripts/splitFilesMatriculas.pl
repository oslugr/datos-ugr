#!/usr/bin/env perl

#Versión 1 - Crea archivos con el nombre de las tablas de los archivos del 1996-2009 y los exporta a .csv

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

sub principal {
    while (@ARGV) {
        my $file_name = shift @ARGV;
        my @directory_name = split(".txt", $file_name);
      
        my $file_data = read_file($file_name);
        mkpath(@directory_name);

        my $cabecera;

        open (ENTRADA, '<:encoding(utf-8)', $file_name) or die "No se puede abrir el archivo ".$file_name;
        my @lineas = <ENTRADA>;
        my $tabla;
        my $tablaCompleta;
        my $finalTabla;
        
        foreach $linea (@lineas){
            #Indica que tipo de matriculación se está extrayendo
            if($linea =~ /Matr.cula: TODA/i){
                $matriculacion = "TODA";
                mkpath(join('',@directory_name)."/TODA");
            }else {
                if($linea =~ /Matr.cula: OFICIAL/i){
                    $matriculacion = "OFICIAL";
                    mkpath(join('',@directory_name)."/OFICIAL");
                }else {
                    if($linea =~ /Matr.cula: LIBRE/i){
                        $matriculacion = "LIBRE";
                        mkpath(join('',@directory_name)."/LIBRE");
                    }
                }
            }
            #Quita de todos las etiquetas de las líneas, principalmente <b> </b>
            $linea =~ s/<.*>(.*)<\/.*>/$1/g;
            
            #Comprueba si la línea es del tipo 1) MATRICULAS UNIVERSITARIAS
            if($linea =~ /\s(\d\).*$)/){
                #Almaceno la cabecera tal cual
                ($cabecera) = $1;
            }else {
                #Comprueba si la línea es del tipo a) Varones de las mastrículas.
                if($linea =~ /\s(\w\).*$)/){
                    #En caso de ser a) varones de las matrículas... añade de qué tabla es.
                    $cabecera = substr($cabecera,0,1).".".$1;
                }
            }
            # Comprueba si en la línea hay | ó _
            if($linea =~ /\s*[\|\_]*/){
                #Guarda en $tabla las cadenas que contienen |........|
                ($tabla) = ($linea =~ /\|.*\|$/g);
                #Le quito la primera barra a la línea si la tiene.
                $tabla =~ s/(\|)//;
                #Elimino espacios a principio de la línea.
                $tabla =~ s/\s+([\w\d]*)/$1/;
                #Quitamos todas las filas que no tienen texto
                $tabla =~ s/^([\s\|]+$)//;
                #Si hay alguna coma en una celda, metemos todo entre comillas
                $tabla =~ s/(\w+), ?(\w+)/$1 $2/g;
                $tablaCompleta .= $tabla."\n";
                $finalTabla = true;
            }
            if(($linea =~ /^\n$/) && $finalTabla){
                #Si hay 3 números en una misma celda, que se elimine el último y se separen los dos primeros
                $tablaCompleta =~ s/(\d+) +(\d+) +(\d+\.\d+)/$1,$2/g;
                #Se quitan los números que muestran los porcentajes
                $tablaCompleta =~ s/(\d+) +(\d+.\d+)/$1/g;
                #Añadimos una , si Varones Mujeres ó Total no tiene nada más en la celda.
                $tablaCompleta =~ s/\|\s+(VARONES)\s+\|/\| $1, \|/g;
                $tablaCompleta =~ s/\|\s+(MUJERES)\s+\|/\| $1, \|/g;
                $tablaCompleta =~ s/\|\s+(TOTALES)\s+\|\n/\| $1, \|\n/g;
                #Si hay una fila con texto o díjitos y un porcentaje en medio, cambiamos el % por una coma
                $tablaCompleta =~ s/(\w*\s)%(\s+\w)/$1,$2/g;
                #Separamos los diferentes números en diferentes celdas
                $tablaCompleta =~ s/(NOREP)/$1,/g;  
                #Se quitan el símbolo de los porcentajes
                $tablaCompleta =~ s/(%|RP%)//g;
                #Se eliminan líneas con comas y espacios
                $tablaCompleta =~ s/,\n/\n/g;
                #Se eliminan líneas que tienen son del tipo |_____|______|
                $tablaCompleta =~ s/(\,\_+)+//g;
                #Se cambian | por ,
                $tablaCompleta =~ s/[\|]/\,/g;
                #Se eliminan todos los guiones bajos _
                $tablaCompleta =~ s/\_//g;
                #Se quitan todas las , que haya seguidas, resultado de las anteriores expresiones.
            #    $tablaCompleta =~ s/(\,{2,})//g;
                $tablaCompleta =~ s/ +/ /g;
                #Se quita la coma del final de línea.
                $tablaCompleta =~ s/(\,\n)/\n/g;
                #Se quitan espacios a principio de línea
                #$tablaCompleta =~ s/\s+([\w\d]*)/$1/;
                #Se eliminan líneas que solo tienen , 
                $tablaCompleta =~ s/(\,){2,}//g;
                #Quitamos las comas solitarias en una fila
                $tablaCompleta =~ s/\n,\s\n/\n/g;
                #Quitamos las filas vacías con espacios en blanco
                $tablaCompleta =~ s/\n\s*\n/\n/g;
                #Se quitan las filas vacías
                $tablaCompleta =~ s/^\n+//;
                #Quitamos esta cadena para poder visualizarlo bien,
                $tablaCompleta =~ s/\s?del , con asignaturas de\s?\n?//;
                #Filtro específico para quitar las comas a CONY e HIJ
                $tablaCompleta =~ s/(CONY),(HIJ)/$1\-$2/g;
                #print $tablaCompleta;
                open (SALIDA, '>>:encoding(utf-8)', join('',@directory_name)."/".$matriculacion."/".$cabecera.".csv");
                    print SALIDA $tablaCompleta;
                close (SALIDA);
                $tablaCompleta="";
                $tabla="";
                $finalTabla=false;
                #my @string = join('',@directory_name)."/".$matriculacion."/".$cabecera.".csv");
                #print $cabecera;
            }
        }
        close(ENTRADA);
    }
}

#Cabecera del documento
principal();
say "[Separando tablas y exportando a .csv]";
say "--> Se crearán subcarpetas con el nombre del archivo pasado por argumento sin la extensión.";
say "[Ejecución terminada con éxito]";
