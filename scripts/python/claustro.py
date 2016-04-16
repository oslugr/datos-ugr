# -*- coding: utf-8 -*-

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

url = "https://oficinavirtual.ugr.es"

paneles = requests.get(url + "/claustro/index.jsp")

statusCode = paneles.status_code
if statusCode == 200:

    html = BeautifulSoup(paneles.text, 'html.parser')
    titulos = html.find_all('h4',{'class':'panel-title'})

    for i, titulo in enumerate(titulos):
        enlace = titulo.find('a').get('href')
        sector = titulo.find('span', {'class' : 'nombreSector'}).getText()

        print "%d\n%s\n%s\n" %(i+1, enlace, sector)

else:
    print "Status Code %d" %statusCode
