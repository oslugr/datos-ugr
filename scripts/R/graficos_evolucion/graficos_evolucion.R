#!/usr/bin/env Rscript

#install.packages("ggplot2")
#install.packages("reshape2")
library("ggplot2")
library("reshape2")

# Archivos de datos
tasa_rendimiento <- paste(getwd(), "/tasa_rendimiento_agrupada.csv", sep="")
datos_rendimiento <- read.csv(file=tasa_rendimiento, header=TRUE, fileEncoding="iso-8859-1", sep=",")
datos_rendimiento_artes <- datos_rendimiento[datos_rendimiento[, "AREA"] == "ARTES Y HUMANIDADES",]
datos_rendimiento_artes$AREA <- NULL
datos_rendimiento_artes <- melt(datos_rendimiento_artes)
names(datos_rendimiento_artes)[2]<-"AÑO"
names(datos_rendimiento_artes)[3]<-"POSICION"
datos_rendimiento_artes$AÑO <- as.character(datos_rendimiento_artes$AÑO)
datos_rendimiento_artes$AÑO[datos_rendimiento_artes$AÑO=="X2011"] <- 2011
datos_rendimiento_artes$AÑO[datos_rendimiento_artes$AÑO=="X2012"] <- 2012
datos_rendimiento_artes$AÑO[datos_rendimiento_artes$AÑO=="X2013"] <- 2013
datos_rendimiento_artes$AÑO[datos_rendimiento_artes$AÑO=="X2014"] <- 2014
datos_rendimiento_artes$AÑO[datos_rendimiento_artes$AÑO=="X2015"] <- 2015
datos_rendimiento_artes$AÑO <- factor(datos_rendimiento_artes$AÑO)

p <- ggplot(datos_rendimiento_artes, aes(x=AÑO, y=POSICION, group=TITULO, colour=TITULO))
p + geom_line()


filas_artes <- nrow(datos_rendimiento)

etiquetaY <- "EVOLUCIÓN"
titulo_1 <- "EVOLUCIÓN DE LA TASA DE RENDIMIENTO EN ARTES Y HUMANIDADES"
titulo_2 <- "EVOLUCIÓN DE LA TASA DE RENDIMIENTO EN CIENCIAS"
titulo_3 <- "EVOLUCIÓN DE LA TASA DE RENDIMIENTO EN CIENCIAS DE LA SALUD"
titulo_4 <- "EVOLUCIÓN DE LA TASA DE RENDIMIENTO EN CIENCIAS SOCIALES Y JURÍDICAS"
titulo_5 <- "EVOLUCIÓN DE LA TASA DE RENDIMIENTO EN INGENIERÍA Y ARQUITECTURA"

ggplot(reshape2::melt(datos_rendimiento_artes), aes(variable, TITULO, group=value)) +
  geom_line(alpha=.5, stat="identity", aes(colour=TITULO)) + 
  xlab(etiquetaY) + ylab("TITULACIÓN") +
  scale_x_discrete(labels=c("2011","2012","2013","2014","2015")) +  ggtitle(titulo_1) + 
  theme(plot.title=element_text(family="Lucida Bright", face="bold", size=20), 
        axis.title=element_text(size=15), axis.text.x=element_text(family="Lucida Bright"), 
        axis.text.y=element_text(size=10), legend.position="none")

cc <- scales::seq_gradient_pal("cornsilk2", "black", "Lab")(seq(0,1,length.out=filas_artes))
 
ggplot(reshape2::melt(datos_rendimiento_artes), aes(variable, TITULO, color=TITULO, group=value)) +
  geom_line(alpha=.5, stat="identity") +
  scale_colour_manual(values=cc) +
  xlab(etiquetaY) + ylab("TITULACIÓN") +
  scale_x_discrete(labels=c("2011","2012","2013","2014","2015")) +  ggtitle(titulo_1) + 
  theme(plot.title=element_text(family="Lucida Bright", face="bold", size=20), 
        axis.title=element_text(size=15), axis.text.x=element_text(family="Lucida Bright"), 
    axis.text.y=element_text(size=10), legend.position="none")