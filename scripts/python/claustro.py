# encoding=utf8
import sys

reload(sys)
sys.setdefaultencoding('utf8')

'''
  Copyright (C) 2016 Germán Martínez Maldonado

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program. If not, see <http://www.gnu.org/licenses/>.
'''

'''
Dependencias:
    beautifulsoup4==4.4.1
    requests==2.9.1
    wsgiref==0.1.2
'''

from bs4 import BeautifulSoup
import requests
import codecs

archivo = codecs.open("claustro.csv", "w", "utf-8")

url = "https://oficinavirtual.ugr.es"

paneles = requests.get(url + "/claustro/index.jsp")

html = BeautifulSoup(paneles.text, 'html.parser')
categorias = html.find_all('h4',{'class':'panel-title'})

for categoria in categorias:
    sector = categoria.find('span', {'class' : 'nombreSector'}).getText()
    enlace = categoria.find('a').get('href')

    subpaneles = requests.get(url + enlace)

    #print "\n\n" + sector
    archivo.write("\n\n" + sector)

    subhtml = BeautifulSoup(subpaneles.text, 'html.parser')
    centros = subhtml.find_all('div',{'class':'panel-default'})

    for centro in centros:
        cabecera = centro.find('div',{'class':'panel-heading'})

        nombre = cabecera.find('p',{'class':'text-left'}).getText()
        num = cabecera.find('p',{'class':'text-right'}).getText().replace('\n', ' ').replace('                          /                                                   ', ' - ').strip()

        #print "\n" + nombre + "\n" + num
        archivo.write("\n" + nombre + "\n" + num)

        try:
            filas = centro.find('tbody').find_all('tr')
            #print "Posición; Candidatos/as; Votos"
            archivo.write("Posición; Candidatos/as; Votos")

            for fila in filas:
                valores = fila.find_all('td')

                posicion = valores[0].getText().replace('\n', ' ').strip()
                candidato = valores[1].getText().replace('\n', ' ').strip()
                votos = valores[2].getText().replace('\n', ' ').strip()

                #print posicion + "; " + candidato + "; " + votos
                archivo.write(posicion + "; " + candidato + "; " + votos)
        except AttributeError:
            #print "NO SE HAN PRESENTADO CANDIDATURAS"
            archivo.write("NO SE HAN PRESENTADO CANDIDATURAS")

archivo.close()
