#!/usr/bin/env Rscript

#install.packages("ggplot2")
#install.packages("reshape2")
library("ggplot2")
library("reshape2")

# Archivos de datos
tasa_rendimiento <- paste(getwd(), "/tasa_rendimiento_agrupada.csv", sep="")
datos_rendimiento <- read.csv(file=tasa_rendimiento, header=TRUE, fileEncoding = "iso-8859-1", sep=",")
etiquetaY <- "EVOLUCIÓN"
titulo <- "EVOLUCIÓN DE LA TASA DE RENDIMIENTO POR TITULACIÓN"

ggplot(reshape2::melt(datos_rendimiento), aes(variable, TITULO, group = value)) +
  geom_line(alpha=.5, stat="identity", aes(colour = TITULO)) + 
  xlab(etiquetaY) + ylab("TITULACIÓN") +
  scale_x_discrete(labels = c("2011","2012","2013","2014","2015")) +
  ggtitle(titulo) + 
  theme(plot.title=element_text(family="Lucida Bright", face="bold", size=20), 
        axis.title=element_text(size=15), axis.text.x=element_text(family="Lucida Bright"), 
        axis.text.y=element_text(size=10), legend.position="none")