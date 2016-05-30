#!/usr/bin/env Rscript

#install.packages("ggplot2")
#install.packages("reshape2")
library("ggplot2")
library("reshape2")

# Función para hacer gráfico genérico
grafico <- function(datos_tasa, area, tasa, completo){
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
          plot.margin = unit(c(0.2, 0.2, 0.2, 0.2), "in"))
}


# Archivos de datos
tasa_rendimiento <- paste(getwd(), "/tasa_rendimiento_posicion.csv", sep="")
tasa_exito <- paste(getwd(), "/tasa_exito_posicion.csv", sep="")
tasa_abandono_inicial <- paste(getwd(), "/tasa_abandono_inicial_posicion.csv", sep="")
datos_rendimiento <- read.csv(file=tasa_rendimiento, header=TRUE, fileEncoding="iso-8859-1", sep=",")
datos_exito <- read.csv(file=tasa_exito, header=TRUE, fileEncoding="iso-8859-1", sep=",")
datos_abandono_inicial <- read.csv(file=tasa_abandono_inicial, header=TRUE, fileEncoding="iso-8859-1", sep=",")

if (!dir.exists("graph")) dir.create("graph", showWarnings = TRUE, recursive = FALSE, mode = "0777")

png("graph/evolucion_rendimiento_artes.png", width=1221, height=1000, units='px')
grafico(datos_rendimiento, "ARTES Y HUMANIDADES", "RENDIMIENTO", TRUE)
dev.off()

png("graph/evolucion_rendimiento_ciencias.png", width=1221, height=1000, units='px')
grafico(datos_rendimiento, "CIENCIAS", "RENDIMIENTO", TRUE)
dev.off()

png("graph/evolucion_rendimiento_salud.png", width=1221, height=1000, units='px')
grafico(datos_rendimiento, "CIENCIAS DE LA SALUD", "RENDIMIENTO", TRUE)
dev.off()

png("graph/evolucion_rendimiento_sociales.png", width=1221, height=1000, units='px')
grafico(datos_rendimiento, "CIENCIAS SOCIALES Y JURÍDICAS", "RENDIMIENTO", TRUE)
dev.off()

png("graph/evolucion_rendimiento_ingenieria.png", width=1221, height=1000, units='px')
grafico(datos_rendimiento, "INGENIERÍA Y ARQUITECTURA", "RENDIMIENTO", TRUE)
dev.off()

png("graph/evolucion_exito_artes.png", width=1221, height=1000, units='px')
grafico(datos_exito, "ARTES Y HUMANIDADES", "EXITO", TRUE)
dev.off()

png("graph/evolucion_exito_ciencias.png", width=1221, height=1000, units='px')
grafico(datos_exito, "CIENCIAS", "EXITO", TRUE)
dev.off()

png("graph/evolucion_exito_salud.png", width=1221, height=1000, units='px')
grafico(datos_exito, "CIENCIAS DE LA SALUD", "EXITO", TRUE)
dev.off()

png("graph/evolucion_exito_sociales.png", width=1221, height=1000, units='px')
grafico(datos_exito, "CIENCIAS SOCIALES Y JURÍDICAS", "EXITO", TRUE)
dev.off()

png("graph/evolucion_exito_ingenieria.png", width=1221, height=1000, units='px')
grafico(datos_exito, "INGENIERÍA Y ARQUITECTURA", "EXITO", TRUE)
dev.off()

png("graph/evolucion_abandono_inicial_artes.png", width=1221, height=1000, units='px')
grafico(datos_abandono_inicial, "ARTES Y HUMANIDADES", "ABANDONO INICIAL", FALSE)
dev.off()

png("graph/evolucion_abandono_inicial_ciencias.png", width=1221, height=1000, units='px')
grafico(datos_abandono_inicial, "CIENCIAS", "ABANDONO INICIAL", FALSE)
dev.off()

png("graph/evolucion_abandono_inicial_salud.png", width=1221, height=1000, units='px')
grafico(datos_abandono_inicial, "CIENCIAS DE LA SALUD", "ABANDONO INICIAL", FALSE)
dev.off()

png("graph/evolucion_abandono_inicial_sociales.png", width=1221, height=1000, units='px')
grafico(datos_abandono_inicial, "CIENCIAS SOCIALES Y JURÍDICAS", "ABANDONO INICIAL", FALSE)
dev.off()

png("graph/evolucion_abandono_inicial_ingenieria.png", width=1221, height=1000, units='px')
grafico(datos_abandono_inicial, "INGENIERÍA Y ARQUITECTURA", "ABANDONO INICIAL", FALSE)
dev.off()