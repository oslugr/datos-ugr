#!/usr/bin/env python
# -*- coding: iso-8859-1 -*-

import sys

reload(sys)
sys.setdefaultencoding('iso-8859-1')

import csv

def processing(infile, outfile):
	with open(infile, 'r') as csvin:
		reader = csv.reader(csvin, delimiter=',', quotechar='"')
		reader.next()

		codigo = aux = year = -1;
		lst = []
		for row in reader:
			if row[0] != codigo:
				aux += 1
				codigo = row[0]
				lst.append([])
				lst[aux].append(row[2])
				year = int(row[1])			

				if year == 2011:
					lst[aux].append(row[3])
				elif year == 2012:
					lst[aux].append('')
					lst[aux].append(row[3])
				elif year == 2013:
					lst[aux].append('')
					lst[aux].append('')
					lst[aux].append(row[3])
				elif year == 2014:
					lst[aux].append('')
					lst[aux].append('')
					lst[aux].append('')
					lst[aux].append(row[3])
				elif year == 2015:
					lst[aux].append('')
					lst[aux].append('')
					lst[aux].append('')
					lst[aux].append('')
					lst[aux].append(row[3])
			else:
				if int(row[1]) == year+1:
					lst[aux].append(row[3])
					year = int(row[1])
				elif int(row[1]) == year+2:
					lst[aux].append('')
					lst[aux].append(row[3])
					year = int(row[1])
				elif int(row[1]) == year+3:
					lst[aux].append('')
					lst[aux].append('')
					lst[aux].append(row[3])
					year = int(row[1])
				elif int(row[1]) == year+4:
					lst[aux].append('')
					lst[aux].append('')
					lst[aux].append('')
					lst[aux].append('')
					year = int(row[1])
			
		with open(outfile, 'w') as csvout:
			writer = csv.writer(csvout, delimiter=',', quotechar='"')
			for row in lst:
				writer.writerow(row)

processing('../tasa_rendimiento.csv', 'tasa_rendimiento_agrupada.csv')
processing('../tasa_exito.csv', 'tasa_exito_agrupada.csv')
processing('../tasa_abandono_inicial.csv', 'tasa_abandono_inicial_agrupada.csv')
processing('../tasa_eficiencia.csv', 'tasa_eficiencia_agrupada.csv')
processing('../tasa_graduacion.csv', 'tasa_graduacion_agrupada.csv')
processing('../tasa_abandono.csv', 'tasa_abandono_agrupada.csv')
