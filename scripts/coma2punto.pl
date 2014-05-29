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
	$file_data =~ s/\"(\d+)\.(\d*)\"/"$1,$2"/g;
	$file_data =~ s/(\d+)\.(\d*)/"$1,$2"/g;
	$file_data =~ s/\"\s*(\d+)\s*\"/"$1,00"/g;
	$file_data =~ s/\,\s*(\d+)\s*[\,\$]/,"$1,00",/g;

	write_file($file_name, $file_data);
}

