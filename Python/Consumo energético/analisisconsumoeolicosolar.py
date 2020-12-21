import  pandas as pd
import numpy as np
from seaborn import boxplot
from seaborn import barplot
import matplotlib.pyplot as plt

df = pd.read_csv('opsd_germany_daily.csv')

#Rellenar con 0 los valores faltantes en Wind y Solar
copia_df = df.copy() #creo copia para no pisar original
copia_df['Wind'] = copia_df['Wind'].fillna(0) #reemplazo valores faltantes de Wind por 0
copia_df['Solar'] = copia_df['Solar'].fillna(0) #reemplazo valores faltantes de Solar por 0

#La columna de Wind+Solar debe coincidir con la suma de Wind y Solar
copia_df = copia_df[['Date', 'Consumption', 'Wind', 'Solar']] #Saco la vieja Wind+Solar
copia_df = copia_df.eval('C = Wind + Solar') #Creo columna que haga la suma Wind+Solar
copia_df = copia_df.rename(columns = {'C': 'Wind+Solar'}) #Renombro la columna

#Crear una tabla pivote que visualice el consumo de Wind+Solar según la fecha, debe ser vertical.
print('Tabla pivote')
consumo_por_fecha = df.pivot_table('Wind+Solar', index = 'Date') #había que hacerlo con el df original
print(consumo_por_fecha


#Reemplazar los valores faltantes de la tabla pivote por la media.
consumo_por_fecha['Wind+Solar'] = consumo_por_fecha['Wind+Solar'].fillna(consumo_por_fecha['Wind+Solar'].mean())

#Visualizar los datos estadísticos del CSV en general.
#Sin reemplazo de NaN
print(df.describe())
print()
#Con reemplazo de Nan
print(copia_df.describe())
print()

#Visualizar los datos estadísticos de la tabla pivote, ¿De qué son esos valores?

print(consumo_por_fecha.describe())

#Crear 3 arreglos: energía solar, energía eólica y consumo energético.
energia_solar = np.array(copia_df['Solar'])
energia_eolica = np.array(copia_df['Wind'])
consumo_energetico = np.array(copia_df['Consumption'])

#Visualizar el consumo de cada tipo de energía en el mismo gráfico, pensar bien qué gráfico elegir.
cols_plot = ['Consumption', 'Solar', 'Wind']
axes = copia_df[cols_plot].plot(subplots=True, title='Daily Totals (Gwh)')
for ax in axes:
    ax.set_ylabel('dt')
plt.show()




