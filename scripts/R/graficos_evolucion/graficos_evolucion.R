#!/usr/bin/env Rscript

#install.packages("ggplot2")
#install.packages("reshape2")
library("ggplot2")
library("reshape2")

# Archivos de datos
tasa_rendimiento <- paste(getwd(), "/tasa_rendimiento_agrupada_.csv", sep="")
datos_rendimiento <- read.csv(file=tasa_rendimiento, header=TRUE, fileEncoding="iso-8859-1", sep=",")
datos_rendimiento_artes <- datos_rendimiento[datos_rendimiento[, "AREA"] == "ARTES Y HUMANIDADES",]
datos_rendimiento_artes$AREA <- NULL
datos_rendimiento_artes$X2011 <- as.numeric(datos_rendimiento_artes$X2011)
datos_rendimiento_artes$X2012 <- as.numeric(datos_rendimiento_artes$X2012)
datos_rendimiento_artes$X2013 <- as.numeric(datos_rendimiento_artes$X2013)
datos_rendimiento_artes$X2014 <- as.numeric(datos_rendimiento_artes$X2014)
datos_rendimiento_artes$X2015 <- as.numeric(datos_rendimiento_artes$X2015)
datos_rendimiento_artes <- melt(datos_rendimiento_artes)
names(datos_rendimiento_artes)[2]<-"ANIO"
names(datos_rendimiento_artes)[3]<-"VALOR"
datos_rendimiento_artes$ANIO <- as.character(datos_rendimiento_artes$ANIO)
datos_rendimiento_artes$ANIO[datos_rendimiento_artes$ANIO=="X2011"] <- 2011
datos_rendimiento_artes$ANIO[datos_rendimiento_artes$ANIO=="X2012"] <- 2012
datos_rendimiento_artes$ANIO[datos_rendimiento_artes$ANIO=="X2013"] <- 2013
datos_rendimiento_artes$ANIO[datos_rendimiento_artes$ANIO=="X2014"] <- 2014
datos_rendimiento_artes$ANIO[datos_rendimiento_artes$ANIO=="X2015"] <- 2015
datos_rendimiento_artes$ANIO <- factor(datos_rendimiento_artes$ANIO)

p <- ggplot(datos_rendimiento_artes, aes(x=ANIO, y=VALOR, group=TITULO, colour=TITULO))
p + geom_line()