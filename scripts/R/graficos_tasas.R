#!/usr/bin/env Rscript

#install.packages("ggplot2")
library("ggplot2")

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

# Gráfico tasa rendimiento 2011
png("tasa_rendimiento_2011.png", width = 1221, height = 1000, units = 'px')
valores <- data.frame(datos_2011[, c(1, 2)])[!is.na(data.frame(datos_2011[, c(1, 2)])$TASA.RENDIMIENTO),]
valores$Color <- "SI"
valores$Error <- NA
media_2011tasaRendimiento <- mean(valores$TASA.RENDIMIENTO)
desviacion_2011tasaRendimiento <- sd(valores$TASA.RENDIMIENTO)
mediana_2011tasaRendimiento <- median(valores$TASA.RENDIMIENTO)
valores$TITULO <- as.character(valores$TITULO)
valores <- rbind(valores, c("VALOR PROMEDIO", media_2011tasaRendimiento, "NO", media_2011tasaRendimiento))
valores$TITULO <- as.factor(valores$TITULO)
valores$TASA.RENDIMIENTO <- as.numeric(valores$TASA.RENDIMIENTO)
valores$Color <- as.factor(valores$Color)
valores$Error <- as.numeric(valores$Error)
valores$TITULO <- reorder(valores$TITULO, valores$TASA.RENDIMIENTO)

ggplot(valores, aes(x=TITULO, y=TASA.RENDIMIENTO)) + 
  geom_bar(aes(fill=Color), width=.5, stat="identity", colour = "black") + 
  geom_errorbar(aes(ymin=Error-desviacion_2011tasaRendimiento, ymax=Error+desviacion_2011tasaRendimiento), width=.2, position=position_dodge(.9)) +
  geom_hline(yintercept = mediana_2011tasaRendimiento) + 
  scale_fill_manual(values=c("blue", "red")) + 
  scale_y_continuous(expand = c(0, 1), limits = c(0, 100), breaks=seq(0, 100, 10)) +
  xlab("TITULACIÓN") + ylab("TASA DE RENDIMIENTO (%)") + coord_flip() + 
  ggtitle("TASA DE RENDIMIENTO POR TITULACIÓN DEL AÑO 2011") + 
  theme(plot.title=element_text(family = "Lucida Bright", face="bold", size=20), 
        axis.title=element_text(size=15), axis.text.x=element_text(family = "Lucida Bright"), 
        axis.text.y=element_text(size=10), legend.position="none")
dev.off()

# Gráfico tasa rendimiento 2012
png("tasa_rendimiento_2012.png", width = 1221, height = 1000, units = 'px')
valores <- data.frame(datos_2012[, c(1, 2)])[!is.na(data.frame(datos_2012[, c(1, 2)])$TASA.RENDIMIENTO),]
valores$TITULO <- reorder(valores$TITULO, valores$TASA.RENDIMIENTO)
ggplot(valores, aes(x=TITULO, y=valores$TASA.RENDIMIENTO)) + 
  geom_bar(width=.5, stat="identity", colour = "black", fill=2) + 
  scale_y_continuous(expand = c(0, 1), limits = c(0, 100), breaks=seq(0, 100, 10)) +
  xlab("TITULACIÓN") + ylab("TASA DE RENDIMIENTO (%)") + coord_flip() + 
  ggtitle("TASA DE RENDIMIENTO POR TITULACIÓN DEL AÑO 2012") + 
  theme(plot.title=element_text(family = "Lucida Bright", face="bold", size=20), 
        axis.title=element_text(size=15), axis.text.y=element_text(size=10))
dev.off()

# Gráfico tasa rendimiento 2013
png("tasa_rendimiento_2013.png", width = 1221, height = 1000, units = 'px')
valores <- data.frame(datos_2013[, c(1, 2)])[!is.na(data.frame(datos_2013[, c(1, 2)])$TASA.RENDIMIENTO),]
valores$TITULO <- reorder(valores$TITULO, valores$TASA.RENDIMIENTO)
ggplot(valores, aes(x=TITULO, y=valores$TASA.RENDIMIENTO)) + 
  geom_bar(width=.5, stat="identity", colour = "black", fill=2) + 
  scale_y_continuous(expand = c(0, 1), limits = c(0, 100), breaks=seq(0, 100, 10)) +
  xlab("TITULACIÓN") + ylab("TASA DE RENDIMIENTO (%)") + coord_flip() + 
  ggtitle("TASA DE RENDIMIENTO POR TITULACIÓN DEL AÑO 2013") + 
  theme(plot.title=element_text(family = "Lucida Bright", face="bold", size=20), 
        axis.title=element_text(size=15), axis.text.y=element_text(size=10))
dev.off()

# Gráfico tasa rendimiento 2014
png("tasa_rendimiento_2014.png", width = 1221, height = 1000, units = 'px')
valores <- data.frame(datos_2014[, c(1, 2)])[!is.na(data.frame(datos_2014[, c(1, 2)])$TASA.RENDIMIENTO),]
valores$TITULO <- reorder(valores$TITULO, valores$TASA.RENDIMIENTO)
ggplot(valores, aes(x=TITULO, y=valores$TASA.RENDIMIENTO)) + 
  geom_bar(width=.5, stat="identity", colour = "black", fill=2) + 
  scale_y_continuous(expand = c(0, 1), limits = c(0, 100), breaks=seq(0, 100, 10)) +
  xlab("TITULACIÓN") + ylab("TASA DE RENDIMIENTO (%)") + coord_flip() + 
  ggtitle("TASA DE RENDIMIENTO POR TITULACIÓN DEL AÑO 2014") + 
  theme(plot.title=element_text(family = "Lucida Bright", face="bold", size=20), 
        axis.title=element_text(size=15), axis.text.y=element_text(size=10))
dev.off()

# Gráfico tasa rendimiento 2015
png("tasa_rendimiento_2015.png", width = 1221, height = 1000, units = 'px')
valores <- data.frame(datos_2015[, c(1, 2)])[!is.na(data.frame(datos_2015[, c(1, 2)])$TASA.RENDIMIENTO),]
valores$TITULO <- reorder(valores$TITULO, valores$TASA.RENDIMIENTO)
ggplot(valores, aes(x=TITULO, y=valores$TASA.RENDIMIENTO)) + 
  geom_bar(width=.5, stat="identity", colour = "black", fill=2) + 
  scale_y_continuous(expand = c(0, 1), limits = c(0, 100), breaks=seq(0, 100, 10)) +
  xlab("TITULACIÓN") + ylab("TASA DE RENDIMIENTO (%)") + coord_flip() + 
  ggtitle("TASA DE RENDIMIENTO POR TITULACIÓN DEL AÑO 2015") + 
  theme(plot.title=element_text(family = "Lucida Bright", face="bold", size=20), 
        axis.title=element_text(size=15), axis.text.y=element_text(size=10))
dev.off()

# Gráfico tasa exito 2011
png("tasa_exito_2011.png", width = 1221, height = 1000, units = 'px')
valores <- data.frame(datos_2011[, c(1, 3)])[!is.na(data.frame(datos_2011[, c(1, 3)])$TASA.EXITO),]
valores$TITULO <- reorder(valores$TITULO, valores$TASA.EXITO)
ggplot(valores, aes(x=TITULO, y=valores$TASA.EXITO)) + 
  geom_bar(width=.5, stat="identity", colour = "black", fill=3) + 
  scale_y_continuous(expand = c(0, 1), limits = c(0, 100), breaks=seq(0, 100, 10)) +
  xlab("TITULACIÓN") + ylab("TASA DE ÉXITO (%)") + coord_flip() + 
  ggtitle("TASA DE ÉXITO POR TITULACIÓN DEL AÑO 2011") + 
  theme(plot.title=element_text(family = "Lucida Bright", face="bold", size=20), 
        axis.title=element_text(size=15), axis.text.y=element_text(size=10))
dev.off()

# Gráfico tasa exito 2012
png("tasa_exito_2012.png", width = 1221, height = 1000, units = 'px')
valores <- data.frame(datos_2012[, c(1, 3)])[!is.na(data.frame(datos_2012[, c(1, 3)])$TASA.EXITO),]
valores$TITULO <- reorder(valores$TITULO, valores$TASA.EXITO)
ggplot(valores, aes(x=TITULO, y=valores$TASA.EXITO)) + 
  geom_bar(width=.5, stat="identity", colour = "black", fill=3) + 
  scale_y_continuous(expand = c(0, 1), limits = c(0, 100), breaks=seq(0, 100, 10)) +
  xlab("TITULACIÓN") + ylab("TASA DE ÉXITO (%)") + coord_flip() + 
  ggtitle("TASA DE ÉXITO POR TITULACIÓN DEL AÑO 2012") + 
  theme(plot.title=element_text(family = "Lucida Bright", face="bold", size=20), 
        axis.title=element_text(size=15), axis.text.y=element_text(size=10))
dev.off()

# Gráfico tasa exito 2013
png("tasa_exito_2013.png", width = 1221, height = 1000, units = 'px')
valores <- data.frame(datos_2013[, c(1, 3)])[!is.na(data.frame(datos_2013[, c(1, 3)])$TASA.EXITO),]
valores$TITULO <- reorder(valores$TITULO, valores$TASA.EXITO)
ggplot(valores, aes(x=TITULO, y=valores$TASA.EXITO)) + 
  geom_bar(width=.5, stat="identity", colour = "black", fill=3) + 
  scale_y_continuous(expand = c(0, 1), limits = c(0, 100), breaks=seq(0, 100, 10)) +
  xlab("TITULACIÓN") + ylab("TASA DE ÉXITO (%)") + coord_flip() + 
  ggtitle("TASA DE ÉXITO POR TITULACIÓN DEL AÑO 2013") + 
  theme(plot.title=element_text(family = "Lucida Bright", face="bold", size=20), 
        axis.title=element_text(size=15), axis.text.y=element_text(size=10))
dev.off()

# Gráfico tasa exito 2014
png("tasa_exito_2014.png", width = 1221, height = 1000, units = 'px')
valores <- data.frame(datos_2014[, c(1, 3)])[!is.na(data.frame(datos_2014[, c(1, 3)])$TASA.EXITO),]
valores$TITULO <- reorder(valores$TITULO, valores$TASA.EXITO)
ggplot(valores, aes(x=TITULO, y=valores$TASA.EXITO)) + 
  geom_bar(width=.5, stat="identity", colour = "black", fill=3) + 
  scale_y_continuous(expand = c(0, 1), limits = c(0, 100), breaks=seq(0, 100, 10)) +
  xlab("TITULACIÓN") + ylab("TASA DE ÉXITO (%)") + coord_flip() + 
  ggtitle("TASA DE ÉXITO POR TITULACIÓN DEL AÑO 2014") + 
  theme(plot.title=element_text(family = "Lucida Bright", face="bold", size=20), 
        axis.title=element_text(size=15), axis.text.y=element_text(size=10))
dev.off()

# Gráfico tasa exito 2015
png("tasa_exito_2015.png", width = 1221, height = 1000, units = 'px')
valores <- data.frame(datos_2015[, c(1, 3)])[!is.na(data.frame(datos_2015[, c(1, 3)])$TASA.EXITO),]
valores$TITULO <- reorder(valores$TITULO, valores$TASA.EXITO)
ggplot(valores, aes(x=TITULO, y=valores$TASA.EXITO)) + 
  geom_bar(width=.5, stat="identity", colour = "black", fill=3) + 
  scale_y_continuous(expand = c(0, 1), limits = c(0, 100), breaks=seq(0, 100, 10)) +
  xlab("TITULACIÓN") + ylab("TASA DE ÉXITO (%)") + coord_flip() + 
  ggtitle("TASA DE ÉXITO POR TITULACIÓN DEL AÑO 2015") + 
  theme(plot.title=element_text(family = "Lucida Bright", face="bold", size=20), 
        axis.title=element_text(size=15), axis.text.y=element_text(size=10))
dev.off()

# Gráfico tasa abandono inicial 2013
png("tasa_abandono_inicial_2013.png", width = 1221, height = 1000, units = 'px')
valores <- data.frame(datos_2013[, c(1, 4)])[!is.na(data.frame(datos_2013[, c(1, 4)])$TASA.ABANDONO.INICIAL),]
valores$TITULO <- reorder(valores$TITULO, valores$TASA.ABANDONO.INICIAL)
ggplot(valores, aes(x=TITULO, y=valores$TASA.ABANDONO.INICIAL)) + 
  geom_bar(width=.5, stat="identity", colour = "black", fill=4) + 
  scale_y_continuous(expand = c(0, 1), limits = c(0, 100), breaks=seq(0, 100, 10)) +
  xlab("TITULACIÓN") + ylab("TASA DE ABANDONO INICIAL (%)") + coord_flip() + 
  ggtitle("TASA DE ABANDONO INICIAL POR TITULACIÓN DEL AÑO 2013") + 
  theme(plot.title=element_text(family = "Lucida Bright", face="bold", size=20), 
        axis.title=element_text(size=15), axis.text.y=element_text(size=10))
dev.off()

# Gráfico tasa abandono inicial 2014
png("tasa_abandono_inicial_2014.png", width = 1221, height = 1000, units = 'px')
valores <- data.frame(datos_2014[, c(1, 4)])[!is.na(data.frame(datos_2014[, c(1, 4)])$TASA.ABANDONO.INICIAL),]
valores$TITULO <- reorder(valores$TITULO, valores$TASA.ABANDONO.INICIAL)
ggplot(valores, aes(x=TITULO, y=valores$TASA.ABANDONO.INICIAL)) + 
  geom_bar(width=.5, stat="identity", colour = "black", fill=4) + 
  scale_y_continuous(expand = c(0, 1), limits = c(0, 100), breaks=seq(0, 100, 10)) +
  xlab("TITULACIÓN") + ylab("TASA DE ABANDONO INICIAL (%)") + coord_flip() + 
  ggtitle("TASA DE ABANDONO INICIAL POR TITULACIÓN DEL AÑO 2014") + 
  theme(plot.title=element_text(family = "Lucida Bright", face="bold", size=20), 
        axis.title=element_text(size=15), axis.text.y=element_text(size=10))
dev.off()

# Gráfico tasa abandono inicial 2015
png("tasa_abandono_inicial_2015.png", width = 1221, height = 1000, units = 'px')
valores <- data.frame(datos_2015[, c(1, 4)])[!is.na(data.frame(datos_2015[, c(1, 4)])$TASA.ABANDONO.INICIAL),]
valores$TITULO <- reorder(valores$TITULO, valores$TASA.ABANDONO.INICIAL)
ggplot(valores, aes(x=TITULO, y=valores$TASA.ABANDONO.INICIAL)) + 
  geom_bar(width=.5, stat="identity", colour = "black", fill=4) + 
  scale_y_continuous(expand = c(0, 1), limits = c(0, 100), breaks=seq(0, 100, 10)) +
  xlab("TITULACIÓN") + ylab("TASA DE ABANDONO INICIAL (%)") + coord_flip() + 
  ggtitle("TASA DE ABANDONO INICIAL POR TITULACIÓN DEL AÑO 2015") + 
  theme(plot.title=element_text(family = "Lucida Bright", face="bold", size=20), 
        axis.title=element_text(size=15), axis.text.y=element_text(size=10))
dev.off()

# Gráfico tasa eficiencia 2014
png("tasa_eficiencia_2014.png", width = 1221, height = 1000, units = 'px')
valores <- data.frame(datos_2014[, c(1, 5)])[!is.na(data.frame(datos_2014[, c(1, 5)])$TASA.EFICIENCIA),]
valores$TITULO <- reorder(valores$TITULO, valores$TASA.EFICIENCIA)
ggplot(valores, aes(x=TITULO, y=valores$TASA.EFICIENCIA)) + 
  geom_bar(width=.5, stat="identity", colour = "black", fill=5) + 
  scale_y_continuous(expand = c(0, 1), limits = c(0, 100), breaks=seq(0, 100, 10)) +
  xlab("TITULACIÓN") + ylab("TASA DE EFICIENCIA (%)") + coord_flip() + 
  ggtitle("TASA DE EFICIENCIA POR TITULACIÓN DEL AÑO 2014") + 
  theme(plot.title=element_text(family = "Lucida Bright", face="bold", size=20), 
        axis.title=element_text(size=15), axis.text.y=element_text(size=10))
dev.off()

# Gráfico tasa eficiencia 2015
png("tasa_eficiencia_2015.png", width = 1221, height = 1000, units = 'px')
valores <- data.frame(datos_2015[, c(1, 5)])[!is.na(data.frame(datos_2015[, c(1, 5)])$TASA.EFICIENCIA),]
valores$TITULO <- reorder(valores$TITULO, valores$TASA.EFICIENCIA)
ggplot(valores, aes(x=TITULO, y=valores$TASA.EFICIENCIA)) + 
  geom_bar(width=.5, stat="identity", colour = "black", fill=5) + 
  scale_y_continuous(expand = c(0, 1), limits = c(0, 100), breaks=seq(0, 100, 10)) +
  xlab("TITULACIÓN") + ylab("TASA DE EFICIENCIA (%)") + coord_flip() + 
  ggtitle("TASA DE EFICIENCIA POR TITULACIÓN DEL AÑO 2015") + 
  theme(plot.title=element_text(family = "Lucida Bright", face="bold", size=20), 
        axis.title=element_text(size=15), axis.text.y=element_text(size=10))
dev.off()

# Gráfico tasa graduacion 2015
png("tasa_graduacion_2015.png", width = 1221, height = 1000, units = 'px')
valores <- data.frame(datos_2015[, c(1, 6)])[!is.na(data.frame(datos_2015[, c(1, 6)])$TASA.GRADUACION),]
valores$TITULO <- reorder(valores$TITULO, valores$TASA.GRADUACION)
ggplot(valores, aes(x=TITULO, y=valores$TASA.GRADUACION)) + 
  geom_bar(width=.5, stat="identity", colour = "black", fill=6) + 
  scale_y_continuous(expand = c(0, 1), limits = c(0, 100), breaks=seq(0, 100, 10)) +
  xlab("TITULACIÓN") + ylab("TASA DE GRADUACION (%)") + coord_flip() + 
  ggtitle("TASA DE GRADUACION POR TITULACIÓN DEL AÑO 2015") + 
  theme(plot.title=element_text(family = "Lucida Bright", face="bold", size=20), 
        axis.title=element_text(size=15), axis.text.y=element_text(size=10))
dev.off()

# Gráfico tasa abandono 2015
png("tasa_abandono_2015.png", width = 1221, height = 1000, units = 'px')
valores <- data.frame(datos_2015[, c(1, 7)])[!is.na(data.frame(datos_2015[, c(1, 7)])$TASA.ABANDONO),]
valores$TITULO <- reorder(valores$TITULO, valores$TASA.ABANDONO)
ggplot(valores, aes(x=TITULO, y=valores$TASA.ABANDONO)) + 
  geom_bar(width=.5, stat="identity", colour = "black", fill=7) + 
  scale_y_continuous(expand = c(0, 1), limits = c(0, 100), breaks=seq(0, 100, 10)) +
  xlab("TITULACIÓN") + ylab("TASA DE ABANDONO (%)") + coord_flip() + 
  ggtitle("TASA DE ABANDONO POR TITULACIÓN DEL AÑO 2015") + 
  theme(plot.title=element_text(family = "Lucida Bright", face="bold", size=20), 
        axis.title=element_text(size=15), axis.text.y=element_text(size=10))
dev.off()