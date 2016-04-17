#       CopyRight 2014 Mario Heredia (mariohm1989@gmail.com)
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

#       Toma los ficheros CSV como matrices con el fin de poder editar el campo
#       requerido y añadir, en su caso, información al final de éste

#       Programa creado para almacenar datos de un fichero que no están en otro


#!/usr/bin/perl
use strict;
use warnings;
use Encode;
use Text::CSV;

my $csv = Text::CSV->new();

my $i = 0;
my $j = 0;
my $k = 0;
my @matrix; #Se usará para almacenar el primer fichero
my @matrix2; #Se usará para almacenar el segundo fichero
my $col;
my @num_cols;
my @array;
my $esta;

# Obtenemos nombres de archivos
my $filein = $ARGV[0] or die "Necesita fichero CSV como parámetro (proyectos UGR)\n";
my $fileout = $ARGV[1] or die "Necesita fichero CSV como parámetro (proyectos COMPLETA)\n";
my @fields;

open(ENTRADA, '<:encoding(iso-8859-1)', $filein) or die "Error en apertura de primer fichero para lectura '$filein' $!\n";

# Pasamos a matriz
while (my $line = <ENTRADA>)
{
    chomp $line;

    if($csv->parse($line))
    {
        my @fields = $csv->fields();

        foreach $col (@fields)
        {
            push @{$matrix[$i]}, $col;
        }
        $i++;

    }
}
# Ya tenemos los datos almacenados en una matriz, podemos cerrarlo
close(ENTRADA);

open(ENTRADA, '<:encoding(iso-8859-1)', $fileout) or die "Error en apertura de segundo fichero para lectura '$fileout' $!\n";

$i = 0;

# Pasamos a matriz
while (my $line = <ENTRADA>)
{
    chomp $line;

    if($csv->parse($line))
    {
        my @fields = $csv->fields();

        foreach $col (@fields)
        {
            push @{$matrix2[$i]}, $col;
        }
        $i++;

    }
}
# Ya tenemos los datos almacenados en una matriz, podemos cerrarlo
close(ENTRADA);

open(SALIDA, '>:encoding(iso-8859-1)', $fileout) or die "Error en apertura de segundo fichero para escritura '$fileout' $!\n";

#Número de columnas del primer fichero y segundo fichero
@num_cols = @{$matrix[0]};

for($i = 1; $i <= $#matrix; $i++)
{
    $esta = 0;
    for($j = 1; $j <= $#matrix2 && $esta == 0; $j++)
    {
        #Buscamos si el de la UGR está en el global
        #Si está, añdimos el investigador principal
        if($matrix[$i][1] eq $matrix2[$j][1])
        {
            $matrix2[$j][$#num_cols] = $matrix[$i][$#num_cols];
            $esta = 1;
        }
    }
    #Si no está, añadimos la información completa al final del fichero
    if($esta == 0)
    {
        push @matrix2, [@{$matrix[$i]}];
    }
}

#Volcamos el contenido de la matriz en el fichero correspondiente
for($i = 0; $i <= $#matrix2; $i++)
{
    for($j = 0; $j < $#num_cols; $j++)
    {
        #Hay campos con comas, ojo con ellos
        if($matrix2[$i][$j] =~ /\,/u)
        {
            #Añadimos comillas dobles
            $matrix2[$i][$j] =~ s/(.+)/"$1"/;
        }

        print SALIDA $matrix2[$i][$j];
        print SALIDA ",";
    }
    #Hay campos con comas, ojo con ellos
    if($matrix2[$i][$j] =~ /\,/u)
    {
        #Añadimos comillas dobles
        $matrix2[$i][$j] =~ s/(.+)/"$1"/;
    }
    print SALIDA $matrix2[$i][$j];
    print SALIDA "\n";
}


close(SALIDA);
