## CONCATENANDO

## lemos documentos de catalogo en R

library(foreign)
library(dplyr)
library(data.table)



temp <- dir(path ="U:/Datos Profeco/Datos Profeco Completos/Quien es quien/2015_3er_Trimestre",pattern="*.DBF")

setwd("U:/Datos Profeco/Datos Profeco Completos/Quien es quien/2015_3er_Trimestre")
for (i in 1:length(temp)) assign(temp[i], read.dbf(temp[i]))


setwd("U:/Datos Profeco/Datos Profeco Completos/Quien es quien/2014")


View(head(PRECIOS_3erTrimestre.DBF))

# indicamos cual es su terminacion
files <- list.files(pattern="*.DBF")


# leemos documentos
DT <- do.call(rbind, lapply(files[4], read.dbf))

DT <- read.dbf(files[4])

DT <- DT[,1:9]

DT <- PRECIOS_3erTrimestre.DBF

View(head(DT))


## AGREGAMOS MARCAS
DT <- full_join(DT,MARCAS.DBF)  , by= c("CVE_PRODUC","CVE_MARCA"))


# AGREGAMOS DESCRIPCION DEL PRODUCTO
# revisasr los tiempos de concatenacion ... tarda mucho este join
DT <- full_join(DT,PRODUCTOS.DBF, by= c("CVE_PRODUC"))


# Agregamos cadenas

DT <- left_join(DT,CADENAS.DBF), by= c("CVE_CADENA"))


# Agregamos ESTABLECIMIENTOS
DT <- left_join(DT,ESTABLECIMIENTOS.DBF, by= c("EST_FOLIO"))

names(DT)[21] <- "CVE_ESTADO"

names(DT)[22] <- "CVE_MUNICI"


# Agregamos estados

DT <- left_join(DT,ESTADOS.DBF, by= c("CVE_ESTADO"))

# Agregamos municipio
DT <- left_join(DT,MUNICIPIOS.DBF, by= c("CVE_ESTADO","CVE_MUNICI"))


# Agregamos ciudad

DT <-  left_join(DT,CIUDADES.DBF, by= c("CVE_CIUDAD"))



# Agregamos CATEGORIAS

DT <- left_join(DT,CATEGORIAS.DBF, by= c("CVE_CATEGO"))

#names(DT)
#View(head(DT,50))

#names(DT)

saveRDS(DT,file="E:/2014/2014_C.rds")


#### cargamos 28 de agosto

#DT <- readRDS("DT.rds")

# guardamos muestra
#sample <- dplyr::sample_n(DT,50000)
#write.csv(sample,"sample2014.csv")


