#!/usr/bin/env perl

#Versión 3 del script para poder sacar los datos de un text formateado de alguna forma concreta.
#Se pueden sacar los datos Año, Alumnos, Varones, Mujeres, Ordinarios y Becas y se pasa a formato .csv a un archivo
# llamado "matriculas-becas-ugr.csv".
#Siempre que se use este programa, sobreescribirá el archivo "matriculas-becas-ugr.csv"

#Para ejecutar este programa hay que instalar las librerías, JSON, Slurp y Switch

use File::Slurp qw(read_file);
use Text::CSV;

use v5.014;

use JSON;
use strict;
use Switch;

my %data;
my $file_json;

sub principal {
    while (@ARGV) {

        my $file_name = shift @ARGV;
        my $file_data = read_file($file_name);

    #Para formatear el archivo entero en csv (Sin terminar)
    #    open( ENTRADA, "$file_name") or die "No se puede abrir $file_name";


    #    $file_data =~ s/[\|\:]/,/g;
    #    $file_data =~ s/_/ /g;

    #    print SALIDA $file_data;
     
        my ($year) = ($file_name =~ /(\d+)\.txt/);
        
        my ($alumnos,$ordinarias) = ($file_data =~ /ALUMNOS:.+?(\d+)\s+.+?ORDINARIA.+?(\d+)\s/s);

        my ($mec) = ($file_data =~ /BECARIO .+? (\d+)/s);

        my ($varones, $mujeres) = ($file_data =~ /VARONES:.+?(\d+)\s+.+?MUJERES:.+?(\d+)/s);

    #    print SALIDA $year.",".$alumnos.",".$varones.",".$mujeres.",".$ordinarias.",".$mec."\n";

        $data{$year} = { Alumnos => $alumnos,
                Varones => $varones,
                Mujeres => $mujeres,
                Ordinarios => $ordinarias,
                Mec => $mec };
    }
    $file_json = (to_json\%data);
}

sub text_to_json {
    open( SALIDA, ">matriculas-becas-ugr.json") or die "No se puede abrir matriculas-becas-ugr.json";
    print SALIDA (to_json\%data);
    close(SALIDA);
}

sub json_to_csv{
    open( SALIDA, ">matriculas-becas-ugr.csv") or die "No se puede abrir matriculas-becas-ugr.csv";
    
    my $hash =from_json( $file_json );

    my %keys;

    for my $k (keys %$hash ) {
        for my $l (keys %{$hash->{$k}} ) {
        $keys{$l} = 1;
        }
    }

    say SALIDA "Año,",join(",", keys %keys );
    for my $k (sort { $a <=> $b } keys %$hash ) {
        my $line = "$k";
        for my $l (keys %keys ) {
        $line .= ",".$hash->{$k}->{$l};
        }
        say SALIDA $line;
    }

    close (SALIDA);
}

sub json_to_geojson{
#El archivo se reescribe siempre que se ejecute el programa
    open( SALIDA, ">matriculas-becas-ugr.gejson") or die "No se puede abrir matriculas-becas-ugr.gejson";
    my $hash =from_json( $file_json );

    my %keys;
    my $year;

    my $geojson_base =<<EOC;
    { "type": "FeatureCollection",
      "features": [
        { "type": "Feature",
          "geometry": {"type": "Point", "coordinates": [-3.600833, 37.178056]}
          }
          ]
    }
EOC

    my $geojson =from_json( $geojson_base);

    $geojson->{'features'}[0]->{'properties'} = $hash->{$year};

    say SALIDA to_json($geojson);


    close(SALIDA);
}

#Cabecera del documento

print "Escoge una opción: \n"; 
print "1. Exportar a json\n";
print "2. Exportar a geojson\n";
print "3. Exportar a csv\n";
print "4. Salir\n";
print "Opción: " ;
my $valor = <STDIN> ;
while ($valor < 1 || $valor > 4){
    print "Error al escoger la opción\n\n";
            print "Escoge una opción: \n"; 
            print "1. Exportar a json\n";
            print "2. Exportar a geojson\n";
            print "3. Exportar a csv\n"; 
            print "4. Salir\n";
            print "Opción: " ;
            $valor = <STDIN> ;
}
switch ($valor) {
    case 1  {   principal();
                text_to_json(); }
    case 2 {    principal(); 
                json_to_geojson(); }
    case 3 {    principal(); 
                json_to_csv();}
    case 4 {exit(1);}
    else { 
    }
}