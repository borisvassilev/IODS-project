# Boris Vassilev
# 2018-11-07
# Exercise 4, Data wrangling

library(dplyr)

hd <- read.csv(paste0("http://s3.amazonaws.com/assets.datacamp.com/production/", "course_2218/datasets/human_development.csv"), stringsAsFactors = F)
gii <- read.csv(paste0("http://s3.amazonaws.com/assets.datacamp.com/production/", "course_2218/datasets/gender_inequality.csv"), stringsAsFactors = F, na.strings = "..")

# Dimensions of the datasets
dim(hd)
dim(gii)

# Structure of the datasets
str(hd)
str(gii)

# Summaries of the variables
summary(hd)
summary(gii)

# Rename columns
hd <- rename(hd,
             HDI=Human.Development.Index..HDI.,
             Life.Exp=Life.Expectancy.at.Birth,
             Edu.Exp=Expected.Years.of.Education,
             Edu.Mean=Mean.Years.of.Education,
             GNI=Gross.National.Income..GNI..per.Capita,
             GNI.m.HDI.rank=GNI.per.Capita.Rank.Minus.HDI.Rank)

gii <- rename(gii,
              GII=Gender.Inequality.Index..GII.,
              Mat.Mor=Maternal.Mortality.Ratio,
              Ado.Birth=Adolescent.Birth.Rate,
              Parli.F=Percent.Representation.in.Parliament,
              Edu2.F=Population.with.Secondary.Education..Female., 
              Edu2.M=Population.with.Secondary.Education..Male.,
              Labo.F=Labour.Force.Participation.Rate..Female.,
              Labo.M=Labour.Force.Participation.Rate..Male.)

# combine weekday and weekend alcohol to alc_use
gii <- mutate(gii, Edu2.FM = Edu2.F / Edu2.M)
gii <- mutate(gii, Labo.FM = Labo.F / Labo.M)

# Join datasets by Country
human <- inner_join(hd, gii, by = 'Country')

# Check the dimensions
dim(human)

# Write dataset to file
write.csv(human, "data/human.csv", row.names = FALSE)
