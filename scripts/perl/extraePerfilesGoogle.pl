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

#		Extrae url de perfiles de Google Schoolar
#		Programa creado específicamente para extraer las urls de los perfiles de #       Google Schoolar de los investigadores de la UGR.

#		El programa busca, en la url ofrecida por argumento, un patrón para
#       extraer lo que buscamos.


use HTML::LinkExtor;
use LWP::Simple;

my $page = get(shift);

my $rec = new HTML::LinkExtor;

$rec -> parse($page);

my @enlaces = $rec -> links;

foreach(@enlaces)
{
    while(my($exc) = splice(@$_, 2))
    {
        next unless $exc =~ m/citations/;
        print "$exc\n";
    }
}

die
