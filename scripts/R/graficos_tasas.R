#!/usr/bin/env Rscript

#install.packages("ggplot2")
#install.packages("ggthemes")
library("ggplot2")
library("ggthemes")

archivo <- paste(getwd(), "/tasas_academicas_2015.csv", sep="")
datos <- read.csv(file=archivo, header=TRUE, sep=",", dec=".")

columna=7
valores=data.frame(datos[, c(1, columna)])[!is.na(data.frame(datos[, c(1, columna)])$TASA.ABANDONO),]
dato_y=valores$TASA.ABANDONO
titulo="TASA DE ABANDONO POR TITULACION DEL AÑO 2015"
titulo_y="TASA DE ABANDONO (%)"
archivo="tasa_abandono_2015.png"
png(archivo, width = 1221, height = 1000, units = 'px')

ggplot(valores, aes(x=TITULO, y=dato_y)) + 
  geom_bar(width=.5, stat="identity", colour = "black", fill=columna) + 
  scale_y_continuous(expand = c(0, 1), limits = c(0, 100), breaks=seq(0, 100, 10)) +
  xlab("TITULACION") + ylab(titulo_y) + coord_flip() + ggtitle(titulo) + 
  theme(plot.title=element_text(face="bold", size=20), axis.title=element_text(size=15), 
        axis.text.y=element_text(size=10))

dev.off()