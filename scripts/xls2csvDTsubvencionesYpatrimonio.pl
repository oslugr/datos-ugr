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

#!/usr/bin/env perl -w

# xls2csvDTsubvencionesYpatrimonio.pl, Este programa trata de exportar los archivos XLS a CSV.
# No es genérico ya que he usado el programa xls2csv (http://search.cpan.org/~ken/xls2csv-1.07/script/xls2csv) que es de uso libre y he
# aplicado un par de filtros para poder visualizar correctamente los archivos ya que a los números a partir del millar (1,000) los ponía
# con una coma y en .csv lo mostraba mal, y también se eliminan separadores a final de línea.

use v5.014;

use strict;
use utf8;
use Text::CSV;
use File::Slurp qw(read_file write_file);

my $command;
my $inFile;


if (-1 == $#ARGV){
	print "[ERROR] Solo debe pasar por argumento archivos con formato \".xls\" para exportarlos a .csv y que sean datos de la Ley de Transparencia más concretamente Subvenciones y Patrimonio.\n";
	exit();
}

foreach my $inFile (@ARGV){

	$inFile =~ /(.*)\.[xX][lL][sS]$/;		
	my $outFile = "$1.csv";
	$command = " xls2csv -x \"$inFile\" -b ISO-8859-1 -c \"$outFile\" -a UTF-8 -q";
	system($command);
	if ($?) {
		print "[ERROR] command failed: $!\n";
		print "[ERROR] No se ha podido ejecutar el comando para la entrada \"$inFile\" y la salida: \"$outFile\"\n";
	}else{


	#Como el programa anterior mete comas como separador a partir de mil, lo voy a quitar para poder previsualizarlo en sitios como OpenData
	my $file_data = read_file("$1.csv");
	#Quitamos comas y comillas,  "9,000.00" -> 9000.00
	$file_data =~ s/\"(\d{1,3}),(\d{3}.\d{2})\"/$1$2/g;
	#Se quitan todas las comas del final de línea
	$file_data =~ s/\,{2,}//g;
	write_file( $outFile,  $file_data );
	print "[OK] El archivo $outFile ha sido exportado correctamente\n";
	}
}

