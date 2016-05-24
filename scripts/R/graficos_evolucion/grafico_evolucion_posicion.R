#!/usr/bin/env Rscript

#install.packages("ggplot2")
#install.packages("reshape2")
library("ggplot2")
library("reshape2")

# Archivos de datos
tasa_rendimiento <- paste(getwd(), "/tasa_rendimiento_agrupada__.csv", sep="")
datos_rendimiento <- read.csv(file=tasa_rendimiento, header=TRUE, fileEncoding="iso-8859-1", sep=",")
datos_rendimiento_artes <- datos_rendimiento[datos_rendimiento[, "AREA"] == "ARTES Y HUMANIDADES",]
orden_artes <- as.character(factor(datos_rendimiento_artes$TITULO))
filas_artes <- nrow(datos_rendimiento_artes)
datos_rendimiento_sociales <- datos_rendimiento[datos_rendimiento[, "AREA"] == "CIENCIAS SOCIALES Y JURÍDICAS",]
orden_sociales <- as.character(factor(datos_rendimiento_sociales$TITULO))
filas_sociales <- nrow(datos_rendimiento_sociales)


datos_rendimiento_artes$AREA <- NULL
datos_rendimiento_artes$TITULO <- factor(datos_rendimiento_artes$TITULO, levels=orden_artes)
grosor <- rev(as.character((seq.int(nrow(datos_rendimiento_artes))/nrow(datos_rendimiento_artes))))
titulos <- as.character(datos_rendimiento_artes$TITULO)
datos_rendimiento_sociales$AREA <- NULL
datos_rendimiento_sociales$TITULO <- factor(datos_rendimiento_sociales$TITULO, levels=orden_sociales)
grosor <- rev(as.character((seq.int(nrow(datos_rendimiento_sociales))/nrow(datos_rendimiento_sociales))))
titulos <- as.character(datos_rendimiento_sociales$TITULO)


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
datos_rendimiento_sociales <- melt(datos_rendimiento_sociales, id=c("TITULO"))
names(datos_rendimiento_sociales)[2]<-"ANIO"
names(datos_rendimiento_sociales)[3]<-"VALOR"
datos_rendimiento_sociales$VALOR <- as.numeric(chartr(",", ".", datos_rendimiento_sociales$VALOR))
datos_rendimiento_sociales$ANIO <- as.character(datos_rendimiento_sociales$ANIO)
datos_rendimiento_sociales$ANIO[datos_rendimiento_sociales$ANIO=="X2011"] <- 2011
datos_rendimiento_sociales$ANIO[datos_rendimiento_sociales$ANIO=="X2012"] <- 2012
datos_rendimiento_sociales$ANIO[datos_rendimiento_sociales$ANIO=="X2013"] <- 2013
datos_rendimiento_sociales$ANIO[datos_rendimiento_sociales$ANIO=="X2014"] <- 2014
datos_rendimiento_sociales$ANIO[datos_rendimiento_sociales$ANIO=="X2015"] <- 2015
datos_rendimiento_sociales$ANIO <- factor(datos_rendimiento_sociales$ANIO)


for (titulo in datos_rendimiento_artes$TITULO){
  indice <- seq.int(length(titulos))
  
  if (titulo == titulos[indice])
    datos_rendimiento_artes$GROSOR <- grosor[indice]
}
for (titulo in datos_rendimiento_sociales$TITULO){
  indice <- seq.int(length(titulos))
  
  if (titulo == titulos[indice])
    datos_rendimiento_sociales$GROSOR <- grosor[indice]
}

datos_rendimiento_artes$GROSOR <- as.numeric(datos_rendimiento_artes$GROSOR)
grosor <- as.numeric(grosor)
datos_rendimiento_sociales$GROSOR <- as.numeric(datos_rendimiento_sociales$GROSOR)
grosor <- as.numeric(grosor)


ggplot(datos_rendimiento_artes, aes(x=ANIO, y=VALOR, group=TITULO, colour=TITULO)) + 
  geom_point() + geom_line() + xlab("AÑO") + ylab("POSICION") +
  ggtitle("EVOLUCIÓN TASA DE RENDIMIENTO EN ARTES Y HUMANIDADES") + 
  scale_y_reverse(expand=c(0.01, 0.01), limits=c(filas_artes, 1), breaks=seq(1, filas_artes, 1), labels=titulos) +
  scale_x_discrete(expand=c(0.05, 0.05)) +
  theme(plot.title=element_text(family="Lucida Bright", face="bold", size=20), 
        axis.title=element_text(size=15), axis.text.x=element_text(family="Lucida Bright"), 
        axis.text.y=element_text(size=10), legend.position="none", 
        plot.margin = unit(c(0.2, 0.2, 0.2, 0.2), "in"))


ggplot(datos_rendimiento_artes, aes(x=ANIO, y=VALOR, group=TITULO, colour=TITULO)) + 
  geom_point() + geom_line() + xlab("AÑO") + ylab("POSICION") +
  ggtitle("EVOLUCIÓN TASA DE RENDIMIENTO EN ARTES Y HUMANIDADES") + 
  scale_y_reverse(expand=c(0.01, 0.01), limits=c(filas_artes, 1), breaks=seq(1, filas_artes, 1), labels=titulos) +
  scale_x_discrete(expand=c(0.05, 0.05)) +
  theme(plot.title=element_text(family="Lucida Bright", face="bold", size=20), 
        axis.title=element_text(size=15), axis.text.x=element_text(family="Lucida Bright"), 
        axis.text.y=element_text(size=10), legend.position="none", 
        plot.margin = unit(c(0.2, 0.2, 0.2, 0.2), "in"))
ggplot(datos_rendimiento_sociales, aes(x=ANIO, y=VALOR, group=TITULO, colour=TITULO)) + 
  geom_point() + geom_line() + xlab("AÑO") + ylab("POSICION") +
  ggtitle("EVOLUCIÓN TASA DE RENDIMIENTO EN CIENCIAS SOCIALES Y JURÍDICAS") + 
  scale_y_reverse(expand=c(0.01, 0.01), limits=c(filas_sociales, 1), breaks=seq(1, filas_sociales, 1), labels=titulos) +
  scale_x_discrete(expand=c(0.05, 0.05)) +
  theme(plot.title=element_text(family="Lucida Bright", face="bold", size=20), 
        axis.title=element_text(size=15), axis.text.x=element_text(family="Lucida Bright"), 
        axis.text.y=element_text(size=10), legend.position="none", 
        plot.margin = unit(c(0.2, 0.2, 0.2, 0.2), "in"))