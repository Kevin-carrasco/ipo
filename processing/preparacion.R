pacman::p_load(dplyr, sjmisc, car, sjlabelled, stargazer, haven, sjPlot, ggplot2, psych)

rm(list=ls())       # borrar todos los objetos en el espacio de trabajo
options(scipen=999) # valores sin notación científica

load(url("https://dataverse.harvard.edu/api/access/datafile/7245118")) #Cargar base de datos
dim(elsoc_long_2016_2022.2) # dimension de la base

proc_data <- elsoc_long_2016_2022.2 %>% filter(ola=="1") %>%
  select(t02_01, # Este barrio es ideal para mi
         t02_02, # Me siento incluido en este barrio
         t02_03, # Me identifico con la gente de este barrio
         t02_04, # Este barrio es parte de mi
         m01,# nivel educacional
         m0_sexo,# sexo
         m0_edad# edad
  )

# Comprobar
names(proc_data)


sjlabelled::get_label(proc_data)

frq(proc_data$t02_01)
proc_data <- proc_data %>% set_na(., na = c(-999, -888, -777, -666))


frq(proc_data$t02_01)


proc_data$t02_01 <- recode(proc_data$t02_01, "1=0; 2=1; 3=2; 4=3; 5=4")
proc_data$t02_02 <- recode(proc_data$t02_02, "1=0; 2=1; 3=2; 4=3; 5=4")
proc_data$t02_03 <- recode(proc_data$t02_03, "1=0; 2=1; 3=2; 4=3; 5=4")
proc_data$t02_04 <- recode(proc_data$t02_04, "1=0; 2=1; 3=2; 4=3; 5=4")

proc_data <- proc_data %>% rename("ideal"=t02_01,
                                  "integracion"=t02_02,
                                  "identificacion"=t02_03,
                                  "pertenencia"=t02_04)

proc_data$ideal <- set_label(x = proc_data$ideal,label = "Este barrio es ideal para mi")
get_label(proc_data$ideal)

proc_data$integracion  <- set_label(x = proc_data$integracion, label = "Me siento integrado en este barrio")
get_label(proc_data$integracion)

proc_data$identificacion  <- set_label(x = proc_data$identificacion, label = "Me identifico con la gente de este barrio")
get_label(proc_data$identificacion)

proc_data$pertenencia  <- set_label(x = proc_data$pertenencia, label = "Me siento parte de este barrio")
get_label(proc_data$pertenencia)

frq(proc_data$ideal)
frq(proc_data$integracion)
frq(proc_data$identificacion)
frq(proc_data$pertenencia)

proc_data$ideal <- set_labels(proc_data$ideal,
                              labels=c( "Totalmente en desacuerdo"=0,
                                        "En desacuerdo"=1,
                                        "Ni de acuerdo ni en desacuerdo"=2,
                                        "De acuerdo"=3,
                                        "Totalmente de acuerdo"=4))

proc_data$integracion <- set_labels(proc_data$integracion,
                                    labels=c( "Totalmente en desacuerdo"=0,
                                              "En desacuerdo"=1,
                                              "Ni de acuerdo ni en desacuerdo"=2,
                                              "De acuerdo"=3,
                                              "Totalmente de acuerdo"=4))

proc_data$identificacion <- set_labels(proc_data$identificacion,
                                       labels=c( "Totalmente en desacuerdo"=0,
                                                 "En desacuerdo"=1,
                                                 "Ni de acuerdo ni en desacuerdo"=2,
                                                 "De acuerdo"=3,
                                                 "Totalmente de acuerdo"=4))

proc_data$pertenencia <- set_labels(proc_data$pertenencia,
                                    labels=c( "Totalmente en desacuerdo"=0,
                                              "En desacuerdo"=1,
                                              "Ni de acuerdo ni en desacuerdo"=2,
                                              "De acuerdo"=3,
                                              "Totalmente de acuerdo"=4))

frq(proc_data$ideal)
frq(proc_data$pertenencia)


frq(proc_data$m01)

proc_data <-as.data.frame(proc_data)
stargazer(proc_data, type="text")

save(proc_data,file = "input/data/elsoc2016_proc.RData")
