# Data Wrangling FA 2022 Final Project
Title: Happiness Correlation with Population Growth

### Introduction:
- My project was looking into the correlation between a country's happiness index score and their population change. I used R Studio to write the code and find statistics. 

### Data Dictionary:
Data Name - Type - Description:

  - Rank - Numeric - Country's rank in the Happiness Report
  - Country - Character - Country's name
  - Whisker-High - Numeric - Highest 25% of data values
  - Whisker-Low - Numeric - Lowest 25% of data values
  - Dystopia - Numeric - The estimated extent to which all other variables fail to explain the Happiness Score
  - Explained By:GDP per Capita - Numeric - The estimated extent to which GDP explains the Happiness Score
  - Explained By:Social Support - Numeric - The estimated extent to which social support explains the Happiness Score
  - Explained By: Healthy Life Expectancy - Numeric - The estimated extent to which Healthy life expectancy explains the Happiness Score
  - Explained By:Freedom to make life choices - Numeric - The estimated extent to which Freedom to make life choices explains the Happiness Score
  - Explained By: - Generosity - Numeric - The estimated extent to which Generosity explains the Happiness Score
  - Explained By:Perceptions of corruption - Numeric - The estimated extent to which Perceptions of corruption explains the Happiness Score
  - Immigrants - Numeric - Number of people who moved to said country in 2022
  - Emigrants - Numeric - Number of people who moved from said country in 2022
  - percPop - Numeric - Percent of population that immigrated in 2022
  - Continents - Character - Continent that each country is in *Added after integration for section 3.3 Analysis 
  - immigrantsUnits - Numeric - Immigration numbers divided by 10,000 *Added after integration for section 3.3 Analysis

### Concluding Thoughts:
- This project combines 141 countries scores from the U.N. World Happiness Report and the countries immigration/emigration numbers from the World Population Review to analyze the role of people moving to/from a country based on the metrics used to score happiness. After performing several correlation functions on the data between overall score and immigration numbers I was unable to confirm that these two variables did in fact have a relationship. When looking at the inverse relationship of score with emigration numbers I was additionally unable to confirm that there was even an inverse role of the two. 
