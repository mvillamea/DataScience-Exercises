import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns
import numpy as np
from pandas.plotting import register_matplotlib_converters

register_matplotlib_converters()

# Import data (Make sure to parse dates. Consider setting index column to 'date'.)
df = pd.read_csv('fcc-forum-pageviews.csv')

# Clean data
df = df[(df.value >= df.value.quantile(0.025)) & (df.value <= df.value.quantile(0.975))]


def draw_line_plot():
    # Draw line plot
    df['date'] = pd.to_datetime(df['date'], format='%Y/%m')
    fig = plt.figure(figsize=(10, 4))
    plt.plot(df.date, df.value, linewidth=1, color='red')
    plt.title("Daily freeCodeCamp Forum Page Views 5/2016-12/2019")
    plt.xlabel('Date')
    plt.ylabel('Page Views')
    # Save image and return fig (don't change this part)
    fig.savefig('line_plot.png')
    return fig


def draw_bar_plot():
    # Copy and modify data for monthly bar plot
    df_bar = df.copy()
    df_bar['date'] = pd.to_datetime(df_bar['date'], format='%Y/%m')  # Getting the date as datetime
    df_bar['year'] = pd.DatetimeIndex(df_bar['date']).year  # Getting the year of the date
    df_bar['Months'] = pd.DatetimeIndex(df_bar['date']).month  # Getting the month of the date as int
    df_bar = df_bar.sort_values(by='Months')
    look_up = {1: 'January', 2: 'February', 3: 'March', 4: 'April', 5: 'May',
               6: 'June', 7: 'July', 8: 'August', 9: 'September', 10: 'October',
               11: 'November', 12: 'December'}

    df_bar['Months'] = df_bar['Months'].apply(lambda x: look_up[x])  # Getting the name of the months
    months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October",
              "November", "December"]
    df_bar["Months"] = pd.Categorical(df_bar["Months"], categories=months)

    # Group and get mean of values
    df_bar = pd.pivot_table(df_bar, values='value', index='year', columns='Months', aggfunc=np.mean)

    # Draw bar plot
    ax = df_bar.plot(kind="bar")
    fig = ax.get_figure()
    fig.set_size_inches(7, 6)
    ax.set_xlabel("Years")
    ax.set_ylabel("Average Page Views")

    # Save image and return fig (don't change this part)
    fig.savefig('bar_plot.png')
    return fig


def draw_box_plot():
    # Prepare data for box plots
    df_box = df.copy()
    df_box.reset_index(inplace=True)
    df_box['date'] = pd.to_datetime(df_box['date'], format='%Y/%m')
    df_box['year'] = [d.year for d in df_box.date]
    df_box['month'] = [d.strftime('%b') for d in df_box.date]
    months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct",
              "Nov", "Dec"]
    df_box["month"] = pd.Categorical(df_box["month"], categories=months)

    # Draw box plots (using Seaborn)
    fig, ax = plt.subplots(1, 2)
    sns.boxplot(x='year', y='value', data=df_box, ax=ax[0])
    a1 = fig.axes[0]
    a1.set_title("Year-wise Box Plot (Trend)")
    a1.set(xlabel='Year', ylabel='Page Views')
    sns.boxplot(x='month', y='value', data=df_box, ax=ax[1])
    a2 = fig.axes[1]
    a2.set_title("Month-wise Box Plot (Seasonality)")
    a2.set(xlabel='Month', ylabel='Page Views')

    # Save image and return fig (don't change this part)
    fig.savefig('box_plot.png')
    return fig
