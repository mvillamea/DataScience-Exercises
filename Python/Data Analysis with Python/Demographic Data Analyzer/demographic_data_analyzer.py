"""In this challenge you must analyze demographic data using Pandas.
You are given a dataset of demographic data that was extracted from the 1994 Census database. """

""" You must use Pandas to answer the following questions:
How many people of each race are represented in this dataset? 
What is the average age of men?
What is the percentage of people who have a Bachelor's degree?
What percentage of people with advanced education (Bachelors, Masters, or Doctorate) make more than 50K?
What percentage of people without advanced education make more than 50K?
What is the minimum number of hours a person works per week?
What percentage of the people who work the minimum number of hours per week have a salary of more than 50K?
What country has the highest percentage of people that earn >50K and what is that percentage?
Identify the most popular occupation for those who earn >50K in India. """


import pandas as pd

def calculate_demographic_data(print_data=True):
    # Read data from file
    df = pd.read_csv('adult.data.csv')

    # How many of each race are represented in this dataset? This should be a Pandas series with race names as the index labels.
    race_count = df['race'].value_counts()

    # What is the average age of men?
    average_age_men = round((df[df.sex=='Male'].mean())['age'], 1)

    # What is the percentage of people who have a Bachelor's degree?
    total_people = df.count()['age']
    percentage_bachelors = round(((df[df.education == 'Bachelors'].count())['age'] / total_people) * 100, 1)

    # What percentage of people with advanced education (`Bachelors`, `Masters`, or `Doctorate`) make more than 50K?
    # What percentage of people without advanced education make more than 50K?

    # with and without `Bachelors`, `Masters`, or `Doctorate`
    advanced_categories = ['Bachelors', 'Masters', 'Doctorate']
    higher_education = df[(df.education.isin(advanced_categories)==True)]
    lower_education = df[(df.education.isin(advanced_categories)==False)]

    # percentage with salary >50K
    higher_education_rich = round((len(higher_education[higher_education['salary']=='>50K'])/len(higher_education))*100, 1)
    lower_education_rich = round((len(lower_education[lower_education['salary']=='>50K'])/len(lower_education))*100, 1)

    # What is the minimum number of hours a person works per week (hours-per-week feature)?
    min_work_hours = df['hours-per-week'].min()

    # What percentage of the people who work the minimum number of hours per week have a salary of >50K?
    num_min_workers = len(df[df['hours-per-week'] == min_work_hours])
    num_min_rich_workers = len(df[(df['hours-per-week'] == min_work_hours) & (df['salary'] == '>50K')])
    rich_percentage = round((num_min_rich_workers / num_min_workers) * 100)

    # What country has the highest percentage of people that earn >50K?
    highest_earning_country = \
    (df.loc[df['salary'] == '>50K', 'native-country'].value_counts() / df['native-country'].value_counts()).fillna(
        0).sort_values(ascending=False).index[0]
    total_pop_highest_earning_country = len(df[df['native-country'] == highest_earning_country])
    rich_highest_earning_country = len(df[(df['native-country'] == highest_earning_country) & (df['salary'] == '>50K')])
    highest_earning_country_percentage = round((rich_highest_earning_country / total_pop_highest_earning_country) * 100,
                                               1)

    # Identify the most popular occupation for those who earn >50K in India.
    top_IN_occupation = (df.loc[(df['native-country'] == 'India') & (df['salary'] == '>50K'), 'occupation'].value_counts() / df['occupation'].value_counts()).fillna(0).sort_values(ascending=False).index[0]

    # DO NOT MODIFY BELOW THIS LINE

    if print_data:
        print("Number of each race:\n", race_count)
        print("Average age of men:", average_age_men)
        print(f"Percentage with Bachelors degrees: {percentage_bachelors}%")
        print(f"Percentage with higher education that earn >50K: {higher_education_rich}%")
        print(f"Percentage without higher education that earn >50K: {lower_education_rich}%")
        print(f"Min work time: {min_work_hours} hours/week")
        print(f"Percentage of rich among those who work fewest hours: {rich_percentage}%")
        print("Country with highest percentage of rich:", highest_earning_country)
        print(f"Highest percentage of rich people in country: {highest_earning_country_percentage}%")
        print("Top occupations in India:", top_IN_occupation)

    return {
        'race_count': race_count,
        'average_age_men': average_age_men,
        'percentage_bachelors': percentage_bachelors,
        'higher_education_rich': higher_education_rich,
        'lower_education_rich': lower_education_rich,
        'min_work_hours': min_work_hours,
        'rich_percentage': rich_percentage,
        'highest_earning_country': highest_earning_country,
        'highest_earning_country_percentage':
        highest_earning_country_percentage,
        'top_IN_occupation': top_IN_occupation
    }
