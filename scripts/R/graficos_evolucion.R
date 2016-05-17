#!/usr/bin/env Rscript

#install.packages("ggplot2")
#install.packages("reshape2")
library("ggplot2")
library("reshape2")

# Archivos de datos
tasa_rendimiento <- paste(getwd(), "/tasa_rendimiento_agrupada.csv", sep="")
datos_rendimiento <- read.csv(file=tasa_rendimiento, header=TRUE, fileEncoding="iso-8859-1", sep=",")
filas <- nrow(datos_rendimiento)
etiquetaY <- "EVOLUCIÓN"
titulo <- "EVOLUCIÓN DE LA TASA DE RENDIMIENTO POR TITULACIÓN"

cc <- scales::seq_gradient_pal("cornsilk2", "black", "Lab")(seq(0,1,length.out=filas))

ggplot(reshape2::melt(datos_rendimiento), aes(variable, TITULO, group=value)) +
  geom_line(alpha=.5, stat="identity", aes(colour=TITULO)) + 
  xlab(etiquetaY) + ylab("TITULACIÓN") +
  scale_x_discrete(labels=c("2011","2012","2013","2014","2015")) +  ggtitle(titulo) + 
  theme(plot.title=element_text(family="Lucida Bright", face="bold", size=20), 
        axis.title=element_text(size=15), axis.text.x=element_text(family="Lucida Bright"), 
        axis.text.y=element_text(size=10), legend.position="none")
 
ggplot(reshape2::melt(datos_rendimiento), aes(variable, TITULO, color=TITULO, group=value)) +
  geom_line(alpha=.5, stat="identity") +
  scale_colour_manual(values=cc) +
  xlab(etiquetaY) + ylab("TITULACIÓN") +
  scale_x_discrete(labels=c("2011","2012","2013","2014","2015")) +  ggtitle(titulo) + 
  theme(plot.title=element_text(family="Lucida Bright", face="bold", size=20), 
        axis.title=element_text(size=15), axis.text.x=element_text(family="Lucida Bright"), 
        axis.text.y=element_text(size=10), legend.position="none")