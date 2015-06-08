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

#       Toma el fichero CSV como una matriz con el fin de que si estamos tratando
#       con columna de enteros todos las celdas sean enteros, o si estamos
#       tratando con una columna de reales, tomar todas las celdas como tal.


#!/usr/bin/perl
use strict;
use warnings;
use Encode;
use Text::CSV;

while(@ARGV)
{
    my $csv = Text::CSV->new();

    my $i = 0;
    my $j = 0;
    my $k = 0;
    my @matrix;
    my $col;
    my @num_cols;
    my @array;
    my @array2;

    # Abrimos archivo CSV
    my $file = shift @ARGV or die "Necesita fichero CSV como parámetro\n";

    open(ENTRADA, '<:encoding(iso-8859-1)', $file) or die "Error en apertura de fichero de lectura '$file' $!\n";

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

    my @copy; # Matriz modificada que tendremos que escribir en el CSV

    @num_cols = @{$matrix[0]};

    for($i = 0; $i <= $#num_cols; $i++)
    {
        for($j = 0; $j <= $#matrix; $j++)
        {
            $copy[$j][$i] = $matrix[$j][$i];
            push(@array, $matrix[$j][$i]);
        }

        # Modificamos columna
        @array2 = &mod(@array);

        # Copiamos a matriz final
        for($j = 0; $j <= $#array2; $j++)
        {
            $copy[$j][$i] = $array2[$j];
        }

        # Vaciamos array
        undef @array;
    }

    # Volvemos a abrir el archivo, ahora en forma de escritura
    open(SALIDA, '>:encoding(iso-8859-1)', $file) or die "Error en apertura de fichero de escritura '$file' $!\n";

    @num_cols = @{$copy[0]};
    #Volcamos el contenido de la matriz en el fichero correspondiente
    for($i = 0; $i <= $#copy; $i++)
    {
        for($j = 0; $j < $#num_cols; $j++)
        {
            #Hay campos con comas, ojo con ellos
            if($copy[$i][$j] =~ /\,/u)
            {
                #Añadimos comillas dobles
                $copy[$i][$j] =~ s/(.+)/"$1"/;
            }

            print SALIDA $copy[$i][$j];
            print SALIDA ",";
        }
        #Hay campos con comas, ojo con ellos
        if($copy[$i][$j] =~ /\,/u)
        {
            #Añadimos comillas dobles
            $copy[$i][$j] =~ s/(.+)/"$1"/;
        }
        print SALIDA $copy[$i][$j];
        print SALIDA "\n";
    }
    # Realizada la escritura, cerramos
    close(SALIDA);

}

# Tratamiento de decimales por columna
sub mod()
{
    # Cogemos parámetro
    my @mat = @_;

    # Tratamiento del array columna
    my @n_cols;
    my $index = 1;
    my $index2 = 0;
    my $index3 = 0;
    my $flag = 1;
    my $elem;

    # Primera pasada para saber si no son uniformes
    while($index <= $#mat)
    {
        $elem = $mat[$index];

        # Uniformidad a decimales
        if($elem =~ /(\-?\d+\,\d{2})/u)
        {
            $index2++;
            # Uniformidad a decimales a cero
            if($elem =~ /(\-?\d+\,00)/u)
            {
                $index3++;
            }
        }

        $index++;
    }

    # Si hay decimales distintos de ,00 -> añadir ,00 a los que no tengan
    if($index2 > 0 && $index2 != $index3)
    {
        $index = 1;

        while($index <= $#mat)
        {
            $elem = $mat[$index];

            if($elem !~ /(\-?\d+\,)/u)
            {
                $elem =~ s/(\-?\d+)/$1,00/;
                $mat[$index] = $elem;
            }

            $index++;
        }
    }

    # Si los decimales que hay, son todos ,00 -> eliminar ,00 a todos
    if($index2 == $index3 && $index3 > 0)
    {
        $index = 1;

        while($index <= $#mat)
        {
            $elem = $mat[$index];
            $elem =~ s/(\-?\d+)\,00/$1/;
            $mat[$index] = $elem;

            $index++;
        }
    }

    # Devolvemos el resultado
    return(@mat);
}
