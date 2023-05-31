library(climaemet)
library(ggplot2)
library(lubridate)
library(tibble)
library(dplyr)

library(naniar)
apikey = "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJibXVuaXpAbW9uZHJhZ29uLmVkdSIsImp0aSI6IjM5N2Y0Zjg2LTE0N2MtNGFjYy05ZjI4LTExYjZiODk3NzE4MCIsImlzcyI6IkFFTUVUIiwiaWF0IjoxNjQ3MjY0NzA4LCJ1c2VySWQiOiIzOTdmNGY4Ni0xNDdjLTRhY2MtOWYyOC0xMWI2Yjg5NzcxODAiLCJyb2xlIjoiIn0.h4cBR_lOro719PbcSJ_4J3DtggMDV2dCcyolWDWv6TQ"
h<-function(empezar,terminar,provincia,altitud){
  tabla<-aemet_daily_clim(
    station = "all",
    start = as.Date(empezar),
    end = as.Date(terminar),
    verbose = FALSE,
    return_sf = FALSE
  )
  str(tabla)
  tabla$prec<- gsub(",", ".", tabla$prec)
  tabla$prec<-as.numeric(tabla$prec)
  str(tabla$prec)
  library(dplyr)
  tabla<-tabla%>%
    filter(provincia==provincia & altitud==altitud)
  library(ggplot2)
  print(ggplot(tabla,aes(x=fecha,y=tmed))+
    geom_line()+ labs(title = "Temperatura"))
  print(ggplot(tabla,aes(x=fecha,y=prec))+
    geom_line()+ labs(title = "Precipitaciones"))
}

h("2022-01-01","2022-05-05",'BILBAO',300)

