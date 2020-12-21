## 1. Cargamos los datos
titanic = read.table(file.choose(), header = T, sep = ',')

## 2. Imprimimos las primeras tres filas del archivo
titanic[1:3,]

## 3, Obtenemos numero de casos (filas) y numero de variables (columnas)
dim(titanic)

## 4. Realizamos el attach de los datos asi se cargan los nombres de las columnas como variables
attach(titanic)

## 5. Obtenemos los nombres de las columnas. Se puede usar el item 2 para ver cuales son los tipos de variables.
names(titanic)

## 6. Primero hacemos una tabla de 2x2 que indica frecuencia de supervivencia, separado por hombres y mujeres
tab6 = table(Survived, Sex)
## Hacemos un barplot de la tabla.
barplot(tab6, col = c("red","blue"))
legend("topleft", legend = c("No sobrevivio", "Sobrevivio"), col = c("red","blue"), pch = 15)
## Aparentemente el sexo fue muy importante en la supervivencia

## 7. Comparamos los boxplots de edad entre los sobrevivientes y los no sobrevivientes
boxplot(Age[which(Survived == 0)], Age[which(Survived == 1)],names = c("No sobrevivientes","Sobrevivientes"))
## A simple vista no parece haber diferencias grandes entre las edades de los dos grupos.
## Tambien podriamos hacer la comparacion al reves
tab7 = table(Survived, Age)
barplot(tab7)
## Aca tampoco parece haber conclusiones claras respecto a la asociacion.

## 8. Idem item 6
tab8 = table(Survived, Pclass)
barplot(tab8,legend = colnames(tab.class))
## La proporcion de sobrevivientes en la clase 1 es mucho mayor a la de la clase 3

## 9.
hist(Fare)
## No parece tener una distribucion normal. A simple vista pueden verse outliers a la derecha.
mean(Fare)
mean(Fare, trim = 0.1)
median(Fare)
## Notar que en este caso media > media 0.1-podada > mediana

## 10. Buscamos cuales son los indices de los pasajeros que pagaron mas caro.
indices = which(Fare == max(Fare))
titanic[indices,]

## 11.
boxplot(Fare[which(Survived == 0)], Fare[which(Survived == 1)],names = c("No sobrevivientes","Sobrevivientes"))
Fare.aux = Fare[-indices]
Survived.aux = Survived[-indices]
boxplot(Fare.aux[which(Survived.aux == 0)], Fare.aux[which(Survived.aux == 1)],names = c("No sobrevivientes","Sobrevivientes"))
## Parece que los sobrevivientes pagaron mas por el ticket que los no sobrevivientes.

## 12.
plot(Age,Fare)
## No parece haber una asociacion demasiado clara entre ambas variables

## 13.
Age.clean = Age[which(!is.na(Age))]
sd(Age.clean)
IQR(Age.clean)/1.349
mad(Age.clean)
## Es dificil decir si estas diferencias son o no significativas. Hagamos un histograma
hist(Age.clean)
## Pareciera no ser normal por la asimetria de las colas.

## 14.

ej14 = function(min.edad){
  total = 0
  for(i in 1:nrow(titanic)){
    if(!is.na(Age[i]) && Age[i] > min.edad){
      if(Sex[i] == "male"){
        total = total + Fare[i]
      } else{
        total = total - Fare[i]
      }
    }
  }
  return(total)
}

ej14(0.5)
ej14(10)
ej14(15)
ej14(20)
ej14(40)
ej14(60)

