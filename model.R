# Carga de datos inicial, tipos de flores con diferentes características 
data(iris)
datos <- iris
#View(datos)

# Selección de una submuestra de 105 (el 70% de los datos)
set.seed(101)
tamano.total <- nrow(datos)
tamano.entreno <- round(150*0.7)
datos.indices <- sample(1:tamano.total , size=tamano.entreno)
datos.entreno <- datos[datos.indices,]
datos.test <- datos[-datos.indices,]

# Cargar todos los paquetes necesarios #primero debes de instalarlos con el comando install.packages("nombre de la paqueteria")
library(ggplot2)
library(lattice)
library(caret)
library(nnet)
library(mlbench)
library(adabag)
library(rpart)


str(datos.entreno)
str(datos.test)

# Ejecución del análisis AdaBoost
modelo <- boosting(Species ~ ., data = datos.entreno)
#aqui el modelo comienza a entrenar y la funcion de boosting tiene la orden de seleccionar la clase (Species) y el dataset de entrenamiento


# Importancia de cada variable  #con esta funcion podemos saber las caracteristicas más importantes en nuestra clasificación tambien es una manera de hacer seleccion de caracteristicas
modelo$importance

# predict necesita el parámetro newdata que son los objetos a predecir o a retar el modelo ya entrenado
predicciones <- predict(object = modelo, newdata=datos.test, type = "class")

predicciones$confusion

# Correctamente clasificados
100 * sum(diag(predicciones$confusion)) / sum(predicciones$confusion)

saveRDS(modelo, "model.rds")
write.csv(datos.entreno, "training.csv")
write.csv(datos.test, "testing.csv")

