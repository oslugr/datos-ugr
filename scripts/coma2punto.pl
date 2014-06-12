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

#Versión 1 - Sustituye las comas por puntos según los criterios que necesito en los .csv, que tengan "" 
#            los valores numéricos, los decimales separados por "," y en caso de tener números sin decimales se los añade.

use File::Slurp qw(read_file write_file);

while (@ARGV){
	my $file_name= shift @ARGV;
	my $file_data=read_file($file_name);
	#Números negativos/positivos con/sin coma de decimales se le añaden decimales.
	if($file_data =~ /(\-?\d{1,3}\.\d{3}(\,\d{2})?)/u){

		#Quitamos los puntos a los miles
		$file_data =~ s/(\d{1,3})\.(\d{3})\.(\d{3})\.(\d{3})(\,\d{2})?/$1$2$3$4$5/g;
		$file_data =~ s/(\d{1,3})\.(\d{3})\.(\d{3})\.(\d{3})(\,\d{2})?/$1$2$3$4$5/g;
		$file_data =~ s/(\d{1,3})\.(\d{3})\.(\d{3})(\,\d{2})?/$1$2$3$4/g;
		$file_data =~ s/(\d{1,3})\.(\d{3})\.(\d{3})(\,\d{2})?/$1$2$3$4/g;
		$file_data =~ s/(\d{1,3})\.(\d{3})(\,\d{2})?/$1$2$3/g;
		$file_data =~ s/(\d{1,3})\.(\d{3})(\,\d{2})?/$1$2$3/g;
	}
	

	#Quitamos espacios antes y después de ""
	#$file_data =~ s/(\ +\")|(\"\ +)/"/g;
	$file_data =~  s/^\n//g;
	if($file_data =~ /(\-?\d+\.\d{2})/u){
		# Quitamos las " "
		$file_data =~ s/\"(\-?[\d\.]+)\"/$1/g;
		# Ponemos nº.nº
		$file_data =~ s/\,\ *(\-?\d+)\ *\,/,$1.00,/g;
		$file_data =~ s/\,\ *(\-?\d+)\ *\,/,$1.00,/g;
		# Ponemos nº.nº para los números que estén al final
		$file_data =~ s/\,\ *(\-?\d+)$/,$1.00/gm;
		# Ponemos "nº.nº"
		$file_data =~ s/\,\ *(\-?\d+\.\d+)\ *\,/,"$1",/g;
		$file_data =~ s/\,\ *(\-?\d+\.\d+)\ *\,/,"$1",/g;
		# Ponemos "nº.nº" a los que están al final
		$file_data =~ s/\,\ *(\-?\d+\.\d+)$/,"$1"/gm;
	}
	#Cambio -931.23 por "-931,23" ó "31.02" por "31,00", etc...
	$file_data =~ s/(\"\s*(\-?\d+)\.(\d*)\s*\")/"$2,$3"/gm;
	#Se quitan filas vacías;
	$file_data =~ s/^(\s*\,)+$//gm;
	#Se cambia columna vacía por un nombre;
	####$file_data =~ s/^(\s*\,)(\S*)//g;
	#Si la primera celda está vacía y en la segunda hay texto, se le añade un guión para que lo detecte ckan
	$file_data =~ s/^(\s*\,)(.*)/-,$2,/gm;
	#Quitamos filas vacías
	

	write_file($file_name, $file_data);
}