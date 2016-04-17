#!/usr/bin/env perl

#       CopyRight 2015 Mario Heredia (mariohm1989@gmail.com)
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

#		Elimina \n que me impiden un correcto tratamiento
#		Programa creado específicamente para los CSV que tienen en el primer
#		campo de cada fila el valor PEFICTE o PEIDIORS

use File::Slurp qw(read_file write_file);

while (@ARGV)
{
	my $file_name= shift @ARGV;
	my $file_data=read_file($file_name);

	#Chapuza: no se me ocurre otra forma de quitar los \n innecesarios

	$file_data =~ s/PEFICTE/..PEFICTE/g;
	$file_data =~ s/PEIDIORS/..PEIDIORS/g;

	$file_data =~ s/(\n)(\w)/ $2/g;
	$file_data =~ s/(\n)(\()/ $2/g;

	$file_data =~ s/..PEFICTE/PEFICTE/g;
	$file_data =~ s/..PEIDIORS/PEIDIORS/g;

	write_file($file_name, $file_data);
}
