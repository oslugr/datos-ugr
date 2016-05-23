#!/usr/bin/env Rscript

#install.packages("ggplot2")
#install.packages("reshape2")
library("ggplot2")
library("reshape2")

# Archivos de datos
tasa_rendimiento <- paste(getwd(), "/tasa_rendimiento_agrupada_.csv", sep="")
datos_rendimiento <- read.csv(file=tasa_rendimiento, header=TRUE, fileEncoding="iso-8859-1", sep=",")
datos_rendimiento_artes <- datos_rendimiento[datos_rendimiento[, "AREA"] == "ARTES Y HUMANIDADES",]
orden_artes <- as.character(factor(datos_rendimiento_artes$TITULO))
filas_artes <- nrow(datos_rendimiento_artes)
datos_rendimiento_artes$AREA <- NULL
datos_rendimiento_artes$TITULO <- factor(datos_rendimiento_artes$TITULO, levels=orden_artes)
datos_rendimiento_artes <- melt(datos_rendimiento_artes, id=c("TITULO"))
names(datos_rendimiento_artes)[2]<-"ANIO"
names(datos_rendimiento_artes)[3]<-"VALOR"
datos_rendimiento_artes$VALOR <- as.numeric(chartr(",", ".", datos_rendimiento_artes$VALOR))
datos_rendimiento_artes$ANIO <- as.character(datos_rendimiento_artes$ANIO)
datos_rendimiento_artes$ANIO[datos_rendimiento_artes$ANIO=="X2011"] <- 2011
datos_rendimiento_artes$ANIO[datos_rendimiento_artes$ANIO=="X2012"] <- 2012
datos_rendimiento_artes$ANIO[datos_rendimiento_artes$ANIO=="X2013"] <- 2013
datos_rendimiento_artes$ANIO[datos_rendimiento_artes$ANIO=="X2014"] <- 2014
datos_rendimiento_artes$ANIO[datos_rendimiento_artes$ANIO=="X2015"] <- 2015
datos_rendimiento_artes$ANIO <- factor(datos_rendimiento_artes$ANIO)

#cc <- scales::seq_gradient_pal("black", "cornsilk2", "Lab")(seq(0,1,length.out=filas_artes))

#datos_rendimiento_artes$TITULO

as.numeric(datos_rendimiento_artes$VALOR[1])
datos_rendimiento_artes$VALOR[1]
as.numeric(is.character(datos_rendimiento_artes$VALOR[1]))

as.numeric(datos_rendimiento_artes$VALOR)

ggplot(datos_rendimiento_artes, aes(x=ANIO, y=VALOR, group=TITULO, colour=TITULO)) + 
geom_point() + geom_line() + xlab("AÑO") + ylab("TASA RENDIMIENTO") +
#scale_colour_manual(values=cc) +
ggtitle("EVOLUCIÓN TASA DE RENDIMIENTO EN ARTES Y HUMANIDADES") + 
scale_y_continuous(expand=c(0.01, 0.01), limits=c(0, 100), breaks=seq(0, 100, 5)) +
coord_cartesian(ylim = c(45, 95)) + 
scale_x_discrete(limits=c("2011", "2012", "2013", "2014", "2015"), expand=c(0.05, 0.05)) +
theme(plot.title=element_text(family="Lucida Bright", face="bold", size=20), 
      axis.title=element_text(size=15), axis.text.x=element_text(family="Lucida Bright"), 
      axis.text.y=element_text(size=10))