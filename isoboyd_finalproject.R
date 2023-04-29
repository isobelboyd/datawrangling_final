#Isobel Boyd
#Final Porject

rm(list=ls())


###Original attempt to webscrape
#website <- read_html("https://worldpopulationreview.com/country-rankings/immigration-by-country")

#immigrants <- xml_text(xml_find_all(website, "//table/tbody/tr/td[2]"))
#"//div[@class='table-wide-inner]//td[@class='title']/a"),
#                 "href")


setwd("Desktop")
library(xml2)
library(readxl)

happiness <- read.csv("rankings.csv")
population <- read.csv("csvData1.csv")

####Data Merging and Cleaning
population2 <- subset(population, country!="American Samoa" & country!="Andorra" & country!="Angola" & 
                        country!="Anguilla" & country!="Antigua And Barbuda" & country!="Aruba" & country!="Bahamas" &
                        country!="Barbados" & country!="Belize" & country!="Bermuda" & country!="Bhutan" & country!="British Virgin Islands" & 
                        country!="Burundi" & country!="Cape Verde" & country!="Cayman Islands" & country!="Central African Republic" &
                        country!="Cook Islands" & country!="Cuba" & country!="Curacao" & country!="Djibouti" & 
                        country!="Dominica" & country!="Equatorial Guinea" & country!="Eritrea" & country!="Falkland Islands" & 
                        country!="Faroe Islands" & country!="Fiji" & country!="French Guiana" & country!="French Polynesia" & 
                        country!="Gibraltar" & country!="Greenland" & country!="Grenada" & country!="Guadeloupe" & 
                        country!="Guam" & country!="Guinea-Bissau" & country!="Guyana" & country!="Haiti" & country!="Isle of Man" & 
                        country!="Kiribati" & country!="Liechtenstein" & country!="Macau" & country!="Maldives" & 
                        country!="Marshall Islands" & country!="Martinique" & country!="Mayotte" & country!="Micronesia" &
                        country!="Monaco" & country!="Montserrat" & country!="Nauru" & country!="New Caledonia" & country!="Niue" & 
                        country!="North Korea" & country!="Northern Mariana Islands" & country!="Oman" & country!="Palau" & 
                        country!="Papua New Guinea" & country!="Puerto Rico" & country!="Qatar" & country!="Republic of the Congo" & 
                        country!="Reunion" & country!="Saint Kitts and Nevis" & country!="Saint Lucia" & country!="Saint Pierre and Miquelon" & 
                        country!="Saint Vincent And The Grenadines" & country!="Samoa" & country!="San Marino" & country!="Sao Tome and Principe" &
                        country!="Seychelles" & country!="Sint Maarten" & country!="Solomon Islands" & country!="Somalia" & country!="South Sudan" &
                        country!="Sudan" & country!="Suriname" & country!="Syria" & country!="Timor-Leste" & country!="Tokelau" & country!="Tonga" &
                        country!="Trinidad and Tobago" & country!="Turks and Caicos Islands" & country!="Tuvalu" & country!="United States Virgin Islands" &
                        country!="Vanuatu" & country!="Vatican City" & country!="Wallis and Futuna" & country!="Western Sahara" & country!="Cyprus")

happiness2 <- subset(happiness, Country!="Gambia" &  Country!="Kosovo" & Country!="Taiwan Province of China" & Country!="Cyprus")

happiness2$Country <- replace(happiness2$Country, happiness2$Country=="Congo", "DR Congo")
happiness2$Country <- replace(happiness2$Country, happiness2$Country=="Czechia", "Czech Republic")
happiness2$Country <- replace(happiness2$Country, happiness2$Country=="Palestinian Territories", "Palestine")

names(happiness2) <-tolower(names(happiness2))

merged_data<-merge(happiness2, population2, by="country")

####Analysis
library(psych)
library(leaflet)
library(dplyr)
##Top 10 Happiness Rank
happyTable <- merged_data[order(merged_data$happiness.score, decreasing = TRUE), ]
happiest <- head(happyTable, 10)

##Top 10 Immigration
immigration <- merged_data[order(merged_data$immigrants, decreasing = TRUE), ]
immigration10 <- head(immigration, 10)

##compare top happiness and top immigration
describe(happiest)
describe(immigration10)

##Bottom 10 Happiness Rank
saddest <- tail(happyTable, 10)

##Top 10 Emigration
emigration <- merged_data[order(merged_data$emigrants, decreasing = TRUE), ]
emigration10 <- head(emigration, 10)

##compare bottom happiness and top emigration
describe(saddest)
describe(emigration10)

##compare susmmary stats of whole data
describe(merged_data)

####3.3
library(data.table)
library(dplyr)
library(ggpubr)
#https://r-graph-gallery.com/choropleth-map.html
#https://r-graph-gallery.com/183-choropleth-map-with-leaflet.html

#add continent column
testDF <- merged_data
continents <- c("asia","europe","africa","south america","asia","oceania",
                "europe","europe","asia","asia","europe","europe","africa",
                "south america","europe","africa","south america","europe",
                "africa","asia","africa","north america","africa","south america",
                "asia","south america","africa","north america","europe","europe",
                "europe","north america","africa","south america","africa",
                "north america","europe","africa","africa","europe","europe",
                "africa","europe","europe","africa","europe","north america",
                "africa","north america","asia","europe","europe","asia","asia",
                "asia","asia","europe","asia", "europe", "africa", "north america",
                "asia", "asia", "asia", "africa", "asia", "asia", "asia", "europe",
                "asia", "africa", "africa", "africa", "europe", "europe", "africa",
                "africa", "asia", "africa", "europe", "africa", "africa", "north america",
                "europe", "asia", "europe", "africa", "africa", "asia", "africa", "asia",
                "europe", "oceania", "north america", "africa", "africa", "europe",
                "europe", "asia", "asia", "north america", "south america", "south america",
                "asia", "europe", "europe", "europe", "europe", "africa", "asia", "africa",
                "europe", "africa", "asia", "europe", "europe", "africa", "asia", "europe",
                "asia", "europe", "europe", "asia", "africa", "asia", "africa", "africa",
                "asia", "asia", "africa", "europe", "asia", "europe", "north america",
                "south america", "asia", "south america", "asia", "asia", "africa", "africa")

testDF <- cbind(testDF, continents)
#country count for each continent
counts <- data.table(table(testDF$continents))

#summary statistics of happiness by continent
tapply(testDF$happiness.score, testDF$continents, summary)

#box plot of continents and score
ggsummarystats(
  testDF, x = "continents", y = "happiness.score", 
  ggfunc = ggboxplot, add = "jitter"
)
#box plot of continents and rank
ggsummarystats(
  testDF, x = "continents", y = "rank", 
  ggfunc = ggboxplot, add = "jitter"
)

testDF$immigrantsUnits <- testDF$immigrants / 1000

#box plot of continents and immigration
ggplot(testDF, aes(continents, immigrantsUnits)) + 
  geom_boxplot(outlier.shape = NA) +
  coord_cartesian(ylim = c(0, 15000))
####3.4
library(tidyverse)
#scatter plot with happiness score and immigration
ggplot(data = merged_data) +
  geom_point(mapping = aes(x = happiness.score, y = immigrants, color = rank))
ggplot(data = merged_data) +
  geom_smooth(mapping = aes(x = happiness.score, y = immigrants))
ggplot(data = testDF) +
  geom_point(mapping = aes(x = happiness.score, y = immigrantsUnits, color = continents)) +
  geom_smooth(mapping = aes(x = happiness.score, y = immigrantsUnits))
plot(merged_data$happiness.score, merged_data$immigrants)

#normality check
#means residuals follow normal distribution. there is no trend
correlation <- lm(happiness.score~immigrants, data=merged_data)
plot(correlation$fitted.values, correlation$residuals)
qqnorm(correlation$residuals)
qqline(correlation$residuals, col='red')
shapiro.test(correlation$residuals)#p-value is .5282, we reject the null bc P > .05

#correlation between happiness and immigration, .2382373
cor(merged_data$happiness.score, merged_data$immigrants, use = "complete.obs")
#correlation between happiness and emigrants, -.120
cor(merged_data$happiness.score, merged_data$emigrants, use = "complete.obs")

##Correlation Between Top 10 pulled
#Top Happiness, -.4075
cor(happiest$happiness.score, happiest$immigrants, use = "complete.obs")
#Top Immigration, .1729
cor(immigration10$happiness.score, immigration10$immigrants, use = "complete.obs")
#Bottom Happiness, -.8471672
cor(saddest$happiness.score, saddest$emigrants, use = "complete.obs")
#Top Emigrants,-.009546
cor(emigration10$happiness.score, emigration10$emigrants, use = "complete.obs")


####3.5 
#linear regression with happiness as a function of life expetancy and GDP
fit <- lm(happiness.score~explained.by..healthy.life.expectancy+explained.by..gdp.per.capita,data = merged_data)
summary(fit)
qqnorm(fit$residuals)
qqline(fit$residuals, col='red')

#correlation between life expectancy and immigration, .1720041
cor(merged_data$explained.by..healthy.life.expectancy, merged_data$immigrants, use = "complete.obs")
#correlation between life expectancy and emigration, .01576
cor(merged_data$explained.by..healthy.life.expectancy, merged_data$emigrants, use = "complete.obs")
#correlation between freedom and immigration, .07780
cor(merged_data$explained.by..freedom.to.make.life.choices, merged_data$immigrants, use = "complete.obs")
#correlation between freedom and emigration, .00332
cor(merged_data$explained.by..freedom.to.make.life.choices, merged_data$emigrants, use = "complete.obs")
#correlation between corruption and immigration, .12687
cor(merged_data$explained.by..perceptions.of.corruption, merged_data$immigrants, use = "complete.obs")
#correlation between corruption and emigrants, -.12732
cor(merged_data$explained.by..perceptions.of.corruption, merged_data$emigrants, use = "complete.obs")
#correlation between generosity and immigration, .0939882
cor(merged_data$explained.by..generosity, merged_data$immigrants, use = "complete.obs")
#correlation between generosity and emigration, .02847624
cor(merged_data$explained.by..generosity, merged_data$emigrants, use = "complete.obs")


##correlation matrix
library(corrplot)
library(Hmisc)

#giving back -> Error in cor(saddest) : 'x' must be numeric
#solution, turn everything numeric into a new df
?cor
str(merged_data)
merged_data$rank <- as.numeric(merged_data$rank)
merged_data$immigrants <- as.numeric(merged_data$immigrants)
merged_data$emigrants <- as.numeric(merged_data$emigrants)

numericDF <- merged_data[,c(3, 7:13, 15)]
colnames(numericDF)[2] <- "GDP"
colnames(numericDF)[3] <- "Social Support"
colnames(numericDF)[4] <- "Life Exp."
colnames(numericDF)[5] <- "Freedom"
colnames(numericDF)[6] <- "Generosity"
colnames(numericDF)[7] <- "Corruption"

#create correlation matrix
res <- round(cor(numericDF), 2)
res2 <- rcorr(as.matrix(numericDF))
png(height=1200, width=1200, pointsize=25, file="overlap.png")
corrplot(res, method = "color", addCoef.col="grey", order = "AOE")

#heatmap
col <- colorRampPalette(c("red", "orange", "yellow"))(20)
heatmap(x = res, col=col, symm = TRUE)

#correlation matrix with just happiness factors
happDF <- merged_data[,c(2, 3, 7:12)]
colnames(happDF)[3] <- "GDP"
colnames(happDF)[4] <- "Social Support"
colnames(happDF)[5] <- "Life Exp."
colnames(happDF)[6] <- "Freedom"
colnames(happDF)[7] <- "Generosity"
colnames(happDF)[8] <- "Corruption"

#create correlation matrix
happCor <- round(cor(happDF), 2)
png(height=1200, width=1200, pointsize=25, file="happCor.png")
corrplot(happCor, method = "color", addCoef.col="grey", order = "AOE")
