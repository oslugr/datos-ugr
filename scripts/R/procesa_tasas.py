#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys

reload(sys)
sys.setdefaultencoding('utf-8')

import csv

with open('tasa_rendimiento.csv', 'r') as csvin:
	reader = csv.reader(csvin, delimiter=',', quotechar='"')

	codigo = aux = year = -1;
	lst = []
	for row in reader:
		#print ', '.join(row)
		if row[0] != codigo:
			aux += 1
			codigo = row[0]
			lst.append([])
			lst[aux].append(row[2])
			lst[aux].append(row[3])
		else:
			lst[aux].append(row[3])
			
		 # print row
	# print aux
	# print lst
	with open('prueba.csv', 'w') as csvout:
		writer = csv.writer(csvout, delimiter=',', quotechar='"')
		for row in lst:
			writer.writerow(row)
	
