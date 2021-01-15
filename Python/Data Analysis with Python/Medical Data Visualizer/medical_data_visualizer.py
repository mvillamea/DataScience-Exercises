import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import numpy as np

# Import data
df = pd.read_csv('medical_examination.csv')

# Add 'overweight' column
df.loc[df['weight']/(df['height']/100)**2 > 25, 'overweight'] = 1
df.loc[df['weight']/(df['height']/100)**2 <= 25, 'overweight'] = 0
df['overweight']=df['overweight'].astype(int)

# Normalize data by making 0 always good and 1 always bad. If the value of 'cholestorol' or 'gluc' is 1, make the value 0. If the value is more than 1, make the value 1.
df['cholesterol'] = df['cholesterol'].apply(lambda x:0 if x==1 else 1)
df['gluc'] = df['gluc'].apply(lambda x:0 if x==1 else 1)

# Draw Categorical Plot
def draw_cat_plot():
    # Create DataFrame for cat plot using `pd.melt` using just the values from 'cholesterol', 'gluc', 'smoke', 'alco', 'active', and 'overweight'.
    df_cat = pd.melt(df, id_vars = ['cardio'], value_vars = ['active', 'alco', 'cholesterol', 'gluc', 'overweight', 'smoke'])
    df_cat = df_cat.groupby(['cardio', 'variable', 'value']).size().rename('total').reset_index()

    # Draw the catplot with 'sns.catplot()'
    graph = sns.catplot(data = df_cat, x = 'variable', y = 'total', kind = 'bar', hue = 'value', col = 'cardio')
    fig = graph.fig
    ax = fig.axes[0].legend()

    # Do not modify the next two lines
    fig.savefig('catplot.png')
    return fig


# Draw Heat Map
def draw_heat_map():
    # Clean the data
    df_heat = df[(df['ap_lo'] <= df['ap_hi'])
                 & (df['height'] >= df['height'].quantile(0.025))
                 & (df['height'] <= df['height'].quantile(0.975))
                 & (df['weight'] >= df['weight'].quantile(0.025))
                 & (df['weight'] <= df['weight'].quantile(0.975))]

    # Calculate the correlation matrix
    corr = df_heat.corr()

    # Generate a mask for the upper triangle
    mask = np.triu(corr)

    # Set up the matplotlib figure
    fig, ax = plt.subplots(figsize=(15,10))

    # Draw the heatmap with 'sns.heatmap()'
    sns.heatmap(corr, mask=mask, vmax=.24, center=0, annot=True, fmt='.1f',
                cbar=True, square=True, linewidths=.1)


    # Do not modify the next two lines
    fig.savefig('heatmap.png')
    return fig
