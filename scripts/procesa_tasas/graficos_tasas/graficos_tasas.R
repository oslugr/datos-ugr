#!/usr/bin/env Rscript

#install.packages("ggplot2")
#install.packages("plyr")
library("ggplot2")
library("plyr")


# Función para hacer gráfico genérico
grafico <- function(datos, color1, color2, vmarcas, inicio, etiquetaY, titulo){
  datos$Color <- "SI"
  datos$Error <- NA
  
  media <- mean(datos$TASA)
  desviacion <- sd(datos$TASA)
  mediana <- median(datos$TASA)
  
  datos$TITULO <- as.character(datos$TITULO)
  datos <- rbind(datos, c("VALOR PROMEDIO TASA", media, "NO", media))
  datos$TITULO <- as.factor(datos$TITULO)
  
  datos$TASA <- as.numeric(datos$TASA)
  datos$Color <- as.factor(datos$Color)
  datos$Error <- as.numeric(datos$Error)
  
  datos$TITULO <- reorder(datos$TITULO, datos$TASA)
  
  ggplot(datos, aes(x=TITULO, y=TASA)) + 
    geom_bar(aes(fill=Color), width=.5, stat="identity", colour="black") + 
    geom_errorbar(aes(ymin=Error-desviacion, ymax=Error+desviacion), width=.2, 
                  position=position_dodge(.9)) + geom_hline(yintercept=mediana) + 
    scale_fill_manual(values=c(color2, color1)) + 
    scale_y_continuous(expand=c(0, 1), limits=c(0, 100), breaks=seq(0, 100, vmarcas)) +
    xlab("TITULACIÓN") + ylab(etiquetaY) + coord_flip(ylim=c(inicio, 100)) + 
    ggtitle(titulo) + 
    theme(plot.title=element_text(family="Lucida Bright", face="bold", size=20), 
          axis.title=element_text(size=15), axis.text.x=element_text(family="Lucida Bright"), 
          axis.text.y=element_text(size=10), legend.position="none")
}


# Archivos de datos
tasas_2011 <- paste(getwd(), "/tasas_academicas_2011.csv", sep="")
tasas_2012 <- paste(getwd(), "/tasas_academicas_2012.csv", sep="")
tasas_2013 <- paste(getwd(), "/tasas_academicas_2013.csv", sep="")
tasas_2014 <- paste(getwd(), "/tasas_academicas_2014.csv", sep="")
tasas_2015 <- paste(getwd(), "/tasas_academicas_2015.csv", sep="")
datos_2011 <- read.csv(file=tasas_2011, header=TRUE, fileEncoding = "iso-8859-1", sep=",", dec=",")
datos_2012 <- read.csv(file=tasas_2012, header=TRUE, fileEncoding = "iso-8859-1", sep=",", dec=",")
datos_2013 <- read.csv(file=tasas_2013, header=TRUE, fileEncoding = "iso-8859-1", sep=",", dec=",")
datos_2014 <- read.csv(file=tasas_2014, header=TRUE, fileEncoding = "iso-8859-1", sep=",", dec=",")
datos_2015 <- read.csv(file=tasas_2015, header=TRUE, fileEncoding = "iso-8859-1", sep=",", dec=",")

if (!dir.exists("graph")) dir.create("graph", showWarnings = TRUE, recursive = FALSE, mode = "0777")

# TASA RENDIMIENTO 2011
datos <- data.frame(datos_2011[, c(2, 3)])[!is.na(data.frame(datos_2011[, c(2, 3)])$TASA.RENDIMIENTO),]
datos <- rename(datos, c("TASA.RENDIMIENTO"="TASA"))

png("graph/tasa_rendimiento_2011.png", width=1221, height=1000, units='px')
grafico(datos, "tomato1", "green", 10, 0, "TASA DE RENDIMIENTO (%)",
        "TASA DE RENDIMIENTO POR TITULACIÓN DEL AÑO 2011")
dev.off()


# TASA RENDIMIENTO 2012
datos <- data.frame(datos_2012[, c(2, 3)])[!is.na(data.frame(datos_2012[, c(2, 3)])$TASA.RENDIMIENTO),]
datos <- rename(datos, c("TASA.RENDIMIENTO"="TASA"))

png("graph/tasa_rendimiento_2012.png", width=1221, height=1000, units='px')
grafico(datos, "tomato1", "green", 10, 0, "TASA DE RENDIMIENTO (%)", 
        "TASA DE RENDIMIENTO POR TITULACIÓN DEL AÑO 2012")
dev.off()


# TASA RENDIMIENTO 2013
datos <- data.frame(datos_2013[, c(2, 3)])[!is.na(data.frame(datos_2013[, c(2, 3)])$TASA.RENDIMIENTO),]
datos <- rename(datos, c("TASA.RENDIMIENTO"="TASA"))

png("graph/tasa_rendimiento_2013.png", width=1221, height=1000, units='px')
grafico(datos, "tomato1", "green", 10, 0, "TASA DE RENDIMIENTO (%)",
        "TASA DE RENDIMIENTO POR TITULACIÓN DEL AÑO 2013")
dev.off()


# TASA RENDIMIENTO 2014
datos <- data.frame(datos_2014[, c(2, 3)])[!is.na(data.frame(datos_2014[, c(2, 3)])$TASA.RENDIMIENTO),]
datos <- rename(datos, c("TASA.RENDIMIENTO"="TASA"))

png("graph/tasa_rendimiento_2014.png", width=1221, height=1000, units='px')
grafico(datos, "tomato1", "green", 10, 0, "TASA DE RENDIMIENTO (%)",
        "TASA DE RENDIMIENTO POR TITULACIÓN DEL AÑO 2014")
dev.off()


# TASA RENDIMIENTO 2015
datos <- data.frame(datos_2015[, c(2, 3)])[!is.na(data.frame(datos_2015[, c(2, 3)])$TASA.RENDIMIENTO),]
datos <- rename(datos, c("TASA.RENDIMIENTO"="TASA"))

png("graph/tasa_rendimiento_2015.png", width=1221, height=1000, units='px')
grafico(datos, "tomato1", "green", 10, 0, "TASA DE RENDIMIENTO (%)",
        "TASA DE RENDIMIENTO POR TITULACIÓN DEL AÑO 2015")
dev.off()


# TASA ÉXITO 2011
datos <- data.frame(datos_2011[, c(2, 4)])[!is.na(data.frame(datos_2011[, c(2, 4)])$TASA.EXITO),]
datos <- rename(datos, c("TASA.EXITO"="TASA"))

png("graph/tasa_exito_2011.png", width=1221, height=1000, units='px')
grafico(datos, "green", "tomato1", 10, 0, "TASA DE ÉXITO (%)", 
        "TASA DE ÉXITO POR TITULACIÓN DEL AÑO 2011")
dev.off()


# TASA ÉXITO 2012
datos <- data.frame(datos_2012[, c(2, 4)])[!is.na(data.frame(datos_2012[, c(2, 4)])$TASA.EXITO),]
datos <- rename(datos, c("TASA.EXITO"="TASA"))

png("graph/tasa_exito_2012.png", width=1221, height=1000, units='px')
grafico(datos, "green", "tomato1", 10, 0, "TASA DE ÉXITO (%)",
        "TASA DE ÉXITO POR TITULACIÓN DEL AÑO 2012")
dev.off()


# TASA ÉXITO 2013
datos <- data.frame(datos_2013[, c(2, 4)])[!is.na(data.frame(datos_2013[, c(2, 4)])$TASA.EXITO),]
datos <- rename(datos, c("TASA.EXITO"="TASA"))

png("graph/tasa_exito_2013.png", width=1221, height=1000, units='px')
grafico(datos, "green", "tomato1", 10, 0, "TASA DE ÉXITO (%)",
        "TASA DE ÉXITO POR TITULACIÓN DEL AÑO 2013")
dev.off()


# TASA ÉXITO 2014
datos <- data.frame(datos_2014[, c(2, 4)])[!is.na(data.frame(datos_2014[, c(2, 4)])$TASA.EXITO),]
datos <- rename(datos, c("TASA.EXITO"="TASA"))

png("graph/tasa_exito_2014.png", width=1221, height=1000, units='px')
grafico(datos, "green", "tomato1", 10, 0, "TASA DE ÉXITO (%)",
        "TASA DE ÉXITO POR TITULACIÓN DEL AÑO 2014")
dev.off()


# TASA ÉXITO 2015
datos <- data.frame(datos_2015[, c(2, 4)])[!is.na(data.frame(datos_2015[, c(2, 4)])$TASA.EXITO),]
datos <- rename(datos, c("TASA.EXITO"="TASA"))

png("graph/tasa_exito_2015.png", width=1221, height=1000, units='px')
grafico(datos, "green", "tomato1", 10, 0, "TASA DE ÉXITO (%)", 
        "TASA DE ÉXITO POR TITULACIÓN DEL AÑO 2015")
dev.off()


# TASA ABANDONO INICIAL 2013
datos <- data.frame(datos_2013[, c(2, 5)])[!is.na(data.frame(datos_2013[, c(2, 5)])$TASA.ABANDONO.INICIAL),]
datos <- rename(datos, c("TASA.ABANDONO.INICIAL"="TASA"))

png("graph/tasa_abandono_inicial_2013.png", width=1221, height=1000, units='px')
grafico(datos, "deepskyblue1", "orange", 10, 0, "TASA DE ABANDONO INICIAL (%)",
        "TASA DE ABANDONO INICIAL POR TITULACIÓN DEL AÑO 2013")
dev.off()


# TASA ABANDONO INICIAL 2014
datos <- data.frame(datos_2014[, c(2, 5)])[!is.na(data.frame(datos_2014[, c(2, 5)])$TASA.ABANDONO.INICIAL),]
datos <- rename(datos, c("TASA.ABANDONO.INICIAL"="TASA"))

png("graph/tasa_abandono_inicial_2014.png", width=1221, height=1000, units='px')
grafico(datos, "deepskyblue1", "orange", 10, 0, "TASA DE ABANDONO INICIAL (%)", 
        "TASA DE ABANDONO INICIAL POR TITULACIÓN DEL AÑO 2014")
dev.off()


# TASA ABANDONO INICIAL 2015
datos <- data.frame(datos_2015[, c(2, 5)])[!is.na(data.frame(datos_2015[, c(2, 5)])$TASA.ABANDONO.INICIAL),]
datos <- rename(datos, c("TASA.ABANDONO.INICIAL"="TASA"))

png("graph/tasa_abandono_inicial_2015.png", width=1221, height=1000, units='px')
grafico(datos, "deepskyblue1", "orange", 10, 0, "TASA DE ABANDONO INICIAL (%)",
        "TASA DE ABANDONO INICIAL POR TITULACIÓN DEL AÑO 2015")
dev.off()


# TASA EFICIENCIA 2014
datos <- data.frame(datos_2014[, c(2, 6)])[!is.na(data.frame(datos_2014[, c(2, 6)])$TASA.EFICIENCIA),]
datos <- rename(datos, c("TASA.EFICIENCIA"="TASA"))

png("graph/tasa_eficiencia_2014.png", width=1221, height=1000, units='px')
grafico(datos, "orange", "deepskyblue1", 5, 70, "TASA DE EFICIENCIA (%)", 
        "TASA DE EFICIENCIA POR TITULACIÓN DEL AÑO 2014")
dev.off()


# TASA EFICIENCIA 2015
datos <- data.frame(datos_2015[, c(2, 6)])[!is.na(data.frame(datos_2015[, c(2, 6)])$TASA.EFICIENCIA),]
datos <- rename(datos, c("TASA.EFICIENCIA"="TASA"))

png("graph/tasa_eficiencia_2015.png", width=1221, height=1000, units='px')
grafico(datos, "orange", "deepskyblue1", 5, 70, "TASA DE EFICIENCIA (%)", 
        "TASA DE EFICIENCIA POR TITULACIÓN DEL AÑO 2015")
dev.off()


# TASA GRADUACIÓN 2015
datos <- data.frame(datos_2015[, c(2, 7)])[!is.na(data.frame(datos_2015[, c(2, 7)])$TASA.GRADUACION),]
datos <- rename(datos, c("TASA.GRADUACION"="TASA"))

png("graph/tasa_graduacion_2015.png", width=1221, height=1000, units='px')
grafico(datos, "yellow", "violetred1", 10, 5, "TASA DE GRADUACIÓN (%)", 
        "TASA DE GRADUACIÓN POR TITULACIÓN DEL AÑO 2015")
dev.off()


# TASA ABANDONO 2015
datos <- data.frame(datos_2015[, c(2, 8)])[!is.na(data.frame(datos_2015[, c(2, 8)])$TASA.ABANDONO),]
datos <- rename(datos, c("TASA.ABANDONO"="TASA"))

png("graph/tasa_abandono_2015.png", width=1221, height=1000, units='px')
grafico(datos, "violetred1", "yellow", 10, 5, "TASA DE ABANDONO (%)",
        "TASA DE ABANDONO POR TITULACIÓN DEL AÑO 2015")
dev.off()