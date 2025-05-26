# Sleep-Health-and-Lifestyle

## 1. Preprocessing
In the preprocessing step, I cleaned and prepared the dataset. For example, the "Blood Pressure" column with character inputs like "126/83" was split into systolic and diastolic columns with int values. Missing values were checked and handled appropriately.


## 2. Univariate Analysis
I analyzed the distribution of each feature. For example, the age histogram shows that the participants are ranges between 30 to 60. And sleep duration mostly ranges between 5 to 9 hours. Categorical features such as sleep disorder and gender are shown in bar charts. For instance, barplots for the BMI shows that almost 50 % of the participants had a normal BMI factor while 40% were overweighted.

## 3. Bivariate Analysis
I explored the relationship between different features. 
![SleepQuality_and_SleepDuration](images/SleepQuality_and_SleepDuration.png) As we might assumed sleep duration and sleep quality have a linear relationship.
![Stress_and_SleepDuration](images/Stress_and_SleepDuration.png)Higher stress levels were generally associated with shorter sleep durations, especially for those with sleep disorders.
![DailySteps_and_SleepQuality](images/DailySteps_and_SleepQuality.png) In another diagram, we analysed the effect of daily steps on sleep quality. The results shows that for the group with no sleep disorder, the daily steps does not affect the sleep quality, while for the insomnia participants, higher number of daily steps resulted in better sleep quality.
![BMI_and_Sleep_Quality](images/BMI_and_Sleep_Quality.png)The analysis of quality of sleep in each BMI category shows that people with normal BMI factor has a better sleep quality while obese and overweighted people have a lower sleep quality.
![BMI_and_Age](images/BMI_and_Age.png) Analysis shows that most of the overweighted participants are middle aged(>45 years), normal BMI factor is common in the range of ( 32 to 42).

## 4. Multivariate Analysis
Using multivariate plots, I tried to understand deeper patterns. For example, I used ggpairs to explore the combined effect of stress, blood pressure, and BMI on sleep duration.
