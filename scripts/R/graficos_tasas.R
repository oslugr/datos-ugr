#!/usr/bin/env Rscript

#install.packages("ggplot2")
library("ggplot2")

archivo="./tasas_academicas_2015.csv"
datos <- read.csv(file=archivo, header=TRUE, sep=",", dec=".")

tasa=datos$TASA.ABANDONO
color=7
titulo="TASA DE ABANDONO POR TITULACION DEL AÑO 2015"
titulo_y="TASA DE ABANDONO (%)"
#size=1221x1000pixels

ggplot(datos, aes(x=TITULO, y=tasa)) + geom_bar(width=.5, stat="identity", 
  colour = "black", fill=color) + coord_flip() + 
  scale_y_continuous(expand = c(0, 1), breaks=seq(0, 100, 10)) + 
  xlab("TITULACION") + ylab(titulo_y) + 
  ggtitle(titulo) + 
  theme(plot.title=element_text(face="bold", size=20), axis.title=element_text(size=15), 
        axis.text.y=element_text(size=10))
