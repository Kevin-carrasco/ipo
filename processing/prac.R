load(url(("https://github.com/cursos-metodos-facso/metod1-MCS/raw/main/resource/files/ELSOC_W05_v1.0_R.RData")))

pacman::p_load(dplyr, # Manipulacion datos
               sjmisc, # Descriptivos
               sjPlot, # Tablas
               sjlabelled, #etiquetas
               kableExtra, #Tablas
               GGally, # Correlaciones
               corrplot) # Correlaciones

options(scipen = 999) # para desactivar notacion cientifica

proc_elsoc <- elsoc_2021 %>% select(edad=m0_edad, 
                                    ingreso=m13, 
                                    educacion=m01, 
                                    desigualdad=c18_11, 
                                    esfuerzo=c18_09, 
                                    inteligencia=c18_10)
names(proc_elsoc)

proc_elsoc <- na.omit(proc_elsoc)
dim(proc_elsoc)
proc_elsoc_original <- proc_elsoc
dim(proc_elsoc)

mean(proc_elsoc_original$esfuerzo); mean(proc_elsoc_original$edad); mean(proc_elsoc$desigualdad)

mean(proc_elsoc_original$esfuerzo, na.rm = TRUE); mean(proc_elsoc$edad, na.rm = TRUE); mean(proc_elsoc_original$desigualdad, na.rm = TRUE)






