#!/usr/bin/env Rscript

#install.packages("ggplot2")
#install.packages("reshape2")
library("ggplot2")
library("reshape2")

# Función para hacer gráfico genérico
grafico <- function(datos_tasa, area, tasa, completo, margen){
  datos <- datos_tasa[datos_tasa[, "AREA"] == area,]
  orden <- as.character(factor(datos$TITULO))
  filas <- nrow(datos)
  
  datos$AREA <- NULL
  datos$TITULO <- factor(datos$TITULO, levels=orden)
  grosor <- rev(as.character((seq.int(nrow(datos))/nrow(datos))))
  titulos <- as.character(datos$TITULO)
  
  datos <- melt(datos, id=c("TITULO"))
  names(datos)[2]<-"ANIO"
  names(datos)[3]<-"VALOR"
  datos$VALOR <- as.numeric(chartr(",", ".", datos$VALOR))
  datos$ANIO <- as.character(datos$ANIO)
  if (completo == TRUE){
    datos$ANIO[datos$ANIO=="X2011"] <- 2011
    datos$ANIO[datos$ANIO=="X2012"] <- 2012
    datos$ANIO[datos$ANIO=="X2013"] <- 2013
    datos$ANIO[datos$ANIO=="X2014"] <- 2014
    datos$ANIO[datos$ANIO=="X2015"] <- 2015
  } else {
    datos$ANIO[datos$ANIO=="X2013"] <- 2013
    datos$ANIO[datos$ANIO=="X2014"] <- 2014
    datos$ANIO[datos$ANIO=="X2015"] <- 2015
  }
  datos$ANIO <- factor(datos$ANIO)
  
  ggplot(datos, aes(x=ANIO, y=VALOR, group=TITULO, colour=TITULO)) + 
    geom_point() + geom_line() + xlab("AÑO") + ylab("POSICION") +
    ggtitle(paste("EVOLUCIÓN DE", tasa, "EN", area, sep=" ")) + 
    scale_y_reverse(expand=c(0.01, 0.01), limits=c(filas, 1), breaks=seq(1, filas, 1), 
                    labels=titulos) +
    scale_x_discrete(expand=c(0.02, 0.02)) +
    theme(plot.title=element_text(family="Lucida Bright", face="bold", size=20), 
          axis.title=element_text(size=15), axis.text.x=element_text(family="Lucida Bright"), 
          axis.text.y=element_text(size=10), legend.position="none", 
          plot.margin = unit(c(0.2, 0.5, 0.2, margen), "in"))
}


# Archivos de datos
tasa_rendimiento <- paste(getwd(), "/tasa_rendimiento_posicion.csv", sep="")
tasa_exito <- paste(getwd(), "/tasa_exito_posicion.csv", sep="")
tasa_abandono_inicial <- paste(getwd(), "/tasa_abandono_inicial_posicion.csv", sep="")
datos_rendimiento <- read.csv(file=tasa_rendimiento, header=TRUE, fileEncoding="iso-8859-1", sep=",")
datos_exito <- read.csv(file=tasa_exito, header=TRUE, fileEncoding="iso-8859-1", sep=",")
datos_abandono_inicial <- read.csv(file=tasa_abandono_inicial, header=TRUE, fileEncoding="iso-8859-1", sep=",")

if (!dir.exists("graph")) dir.create("graph", showWarnings = TRUE, recursive = FALSE, mode = "0777")

grafico(datos_abandono_inicial, "CIENCIAS SOCIALES Y JURÍDICAS", "ABANDONO INICIAL", FALSE, 0.2)

