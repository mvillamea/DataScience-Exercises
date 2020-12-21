import  pandas as pd
import numpy as np
from seaborn import barplot
import matplotlib.pyplot as plt

df = pd.read_csv('titanic3.csv')

"""Obtener los nombres de todas las columnas, luego iterar ese objeto e imprimir renglón a
renglón lo siguiente:
“Valores nulos en Survived: 10” donde 10 sea el total de valores nulos o faltantes en la
columna Survived"""

# cant_nulos_columna imprime la cantidad de valores nulos que hay en cada columna de un dataframe dado
def cant_nulos_columna(dataframe):
    name_columns = dataframe.columns.values
    for i in range(len(name_columns)):
        print("Valores nulos en", name_columns[i], ":", dataframe.isnull().sum()[i])

cant_nulos_columna(df)


#Averiguar cuál fue la media de las edades e imprimir “El promedio de edades fue: prom”

media_edades = np.mean(df.age)

print('El promedio de las edades fue:', media_edades)


#Crear una tabla con la cantidad de sobrevivientes divididos por sexo

cant_sobrev_por_sexo = df.pivot_table('survived', columns = 'sex', aggfunc=np.sum)
print(cant_sobrev_por_sexo)

#Otra forma para que queden female y male como filas
female = df[df.sex=='female']
survived_female = female[female.survived == 1]
print(len(survived_female.index))
cant_surv_female = len(survived_female.index)

male = df[df.sex=='male']
survived_male = male[male.survived == 1]
print(len(survived_male.index))
cant_surv_male = len(survived_male.index)

sobrev_por_sexo = pd.DataFrame({'sex': ['Female', 'Male'], 'survived': [cant_surv_female, cant_surv_male]})
print(sobrev_por_sexo)

#Graficar esa tabla con un gráfico acorde

#barplot

barplot(x='sex', y='survived', data=sobrev_por_sexo)
plt.show()