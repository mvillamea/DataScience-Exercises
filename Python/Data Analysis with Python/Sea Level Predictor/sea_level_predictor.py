import pandas as pd
import matplotlib.pyplot as plt
from scipy.stats import linregress
import numpy as np

def draw_plot():
    # Read data from file
    df = pd.read_csv('epa-sea-level.csv', float_precision='legacy')

    # Create scatter plot
    """fig = plt.figure()"""
    plt.scatter(x='Year', y='CSIRO Adjusted Sea Level', data=df)

    # Create first line of best fit
    res1 = linregress(x=df['Year'], y=df['CSIRO Adjusted Sea Level'])
    x1 = np.arange(df["Year"].min(), 2050, 1)
    plt.plot(x1, res1.intercept + res1.slope * x1, "red")

    # Create second line of best fit
    df_2000 = df[df['Year']>=2000]
    res2 = linregress(x=df_2000['Year'], y=df_2000['CSIRO Adjusted Sea Level'])
    x2 = np.arange(2000, 2050, 1)
    plt.plot(x2, res2.intercept + res2.slope * x2, "green")

    # Add labels and title
    plt.title('Rise in Sea Level')
    plt.xlabel('Year')
    plt.ylabel('Sea Level (inches)')

    # Save plot and return data for testing (DO NOT MODIFY)
    plt.savefig('sea_level_plot.png')
    return plt.gca()