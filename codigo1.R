library(climaemet)
library(ggplot2)
library(lubridate)
library(tibble)
library(dplyr)

library(naniar)
apikey = "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJibXVuaXpAbW9uZHJhZ29uLmVkdSIsImp0aSI6IjM5N2Y0Zjg2LTE0N2MtNGFjYy05ZjI4LTExYjZiODk3NzE4MCIsImlzcyI6IkFFTUVUIiwiaWF0IjoxNjQ3MjY0NzA4LCJ1c2VySWQiOiIzOTdmNGY4Ni0xNDdjLTRhY2MtOWYyOC0xMWI2Yjg5NzcxODAiLCJyb2xlIjoiIn0.h4cBR_lOro719PbcSJ_4J3DtggMDV2dCcyolWDWv6TQ"
#2.	Con el paquete climaemet genera una consulta para graficar la temperatura y las precipitaciones medias en la
#provincia CADIZ en los primeros cinco meses del año 2022, pero considerando solo las estaciones con una altitud inferior a 500 metros (2).

tabla<-aemet_daily_clim(
  station = "all",
  start = as.Date("2022-01-01"),
  end = as.Date("2022-05-31"),
  verbose = FALSE,
  return_sf = FALSE
)
library(dplyr)
tabla<-tabla%>%
  filter(provincia=='CADIZ' & altitud<500)
library(ggplot2)
ggplot(tabla,aes(x=fecha,y=tmed))+
  geom_line()+ labs(title = "Temperatura")
str(tabla)
tabla$prec<- gsub(",", ".", tabla$prec)
str(tabla$prec)
tabla$prec<-as.numeric(tabla$prec)
ggplot(tabla,aes(x=fecha,y=prec))+
  geom_line()+ labs(title = "Precipitaciones")
