#!/usr/bin/env Rscript

library("ggplot2")
library("reshape2")
library(ggthemes)

# Archivos de datos
tasa_rendimiento <- paste(getwd(), "/tasa_rendimiento_valor.csv", sep="")
datos_rendimiento <- read.csv(file=tasa_rendimiento, header=TRUE, fileEncoding="iso-8859-1", sep=",")
datos_rendimiento_ingenieria <- datos_rendimiento[datos_rendimiento[, "AREA"] == "INGENIERÍA Y ARQUITECTURA",]
orden_ingenieria <- as.character(factor(datos_rendimiento_ingenieria$TITULO))
filas_ingenieria <- nrow(datos_rendimiento_ingenieria)

datos_rendimiento_ingenieria$AREA <- NULL
datos_rendimiento_ingenieria$TITULO <- factor(datos_rendimiento_ingenieria$TITULO, levels=orden_ingenieria)
grosor <- rev(as.character((seq.int(nrow(datos_rendimiento_ingenieria))/nrow(datos_rendimiento_ingenieria))))
titulos <- as.character(datos_rendimiento_ingenieria$TITULO)

datos_rendimiento_ingenieria <- melt(datos_rendimiento_ingenieria, id=c("TITULO"))
names(datos_rendimiento_ingenieria)[2]<-"ANIO"
names(datos_rendimiento_ingenieria)[3]<-"VALOR"
datos_rendimiento_ingenieria$VALOR <- as.numeric(chartr(",", ".", datos_rendimiento_ingenieria$VALOR))
datos_rendimiento_ingenieria$ANIO <- as.character(datos_rendimiento_ingenieria$ANIO)
datos_rendimiento_ingenieria$ANIO[datos_rendimiento_ingenieria$ANIO=="X2011"] <- 2011
datos_rendimiento_ingenieria$ANIO[datos_rendimiento_ingenieria$ANIO=="X2012"] <- 2012
datos_rendimiento_ingenieria$ANIO[datos_rendimiento_ingenieria$ANIO=="X2013"] <- 2013
datos_rendimiento_ingenieria$ANIO[datos_rendimiento_ingenieria$ANIO=="X2014"] <- 2014
datos_rendimiento_ingenieria$ANIO[datos_rendimiento_ingenieria$ANIO=="X2015"] <- 2015
datos_rendimiento_ingenieria$ANIO <- factor(datos_rendimiento_ingenieria$ANIO)

#datos_rendimiento_ingenieria$GROSOR <- as.numeric(datos_rendimiento_ingenieria$GROSOR)
#grosor <- as.numeric(grosor)

#datos_rendimiento_ingenieria$GROSOR <- factor(datos_rendimiento_ingenieria$TITULO, levels=as.character((seq.int(nrow(datos_rendimiento_ingenieria))/nrow(datos_rendimiento_ingenieria))*1.5))

#cc <- scales::seq_gradient_pal("black", "cornsilk2", "Lab")(seq(0,1,length.out=filas_ingenieria))

limites.y <-  c(20, 80)
ggplot(datos_rendimiento_ingenieria, aes(x=ANIO, y=VALOR, group=TITULO, colour=TITULO)) + 
    geom_point(data=datos_rendimiento_ingenieria,aes(size=VALOR))+ geom_line(data=datos_rendimiento_ingenieria, aes(size=3)) + xlab("AÑO") + ylab("TASA RENDIMIENTO") +
  ggtitle("EVOLUCIÓN TASA DE RENDIMIENTO EN INGENIERÍA Y ARQUITECTURA") + 
  scale_y_continuous(expand=c(0.01, 0.01), limits=c(0, 100), breaks=seq(0, 100, 5)) +
  coord_cartesian(ylim = limites.y) + 
  scale_x_discrete(limits=c("2011", "2012", "2013", "2014", "2015"), expand=c(0.02, 0.02)) +
  theme(plot.title=element_text(family="Lucida Bright", face="bold", size=20), 
        axis.title=element_text(size=15), axis.text.x=element_text(family="Lucida Bright"), 
        axis.text.y=element_text(size=10))+theme_tufte()

## ggplot(datos_rendimiento_ingenieria, aes(x=ANIO, y=VALOR, group=TITULO, colour=TITULO)) + 
## geom_point(size=1.5) + geom_line(aes(size=GROSOR)) + xlab("AÑO") + ylab("TASA RENDIMIENTO") +
## ggtitle("EVOLUCIÓN TASA DE RENDIMIENTO EN INGENIERÍA Y ARQUITECTURA") + 
## scale_y_continuous(expand=c(0.01, 0.01), limits=c(0, 100), breaks=seq(0, 100, 5)) +
## coord_cartesian(ylim = limites.y) + scale_size(guide = "none") +
## scale_x_discrete(limits=c("2011", "2012", "2013", "2014", "2015"), expand=c(0.02, 0.02)) +
## theme(plot.title=element_text(family="Lucida Bright", face="bold", size=20), 
##       axis.title=element_text(size=15), axis.text.x=element_text(family="Lucida Bright"), 
##       axis.text.y=element_text(size=10))
