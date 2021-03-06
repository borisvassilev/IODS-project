# Boris Vassilev
# 2018.11.18
# Exercise 3: Logistic regression

# Load needed libraries
library(dplyr)


math <- read.table("student-mat.csv", sep=";", header=T)
por <- read.table("student-por.csv", sep=";", header=T)


dim(math)
# [1] 395 33
str(math)

dim(por)
# [1] 649  33
str(por)



# Common columns to use as identifiers
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu", "Fedu","Mjob","Fjob","reason","nursery","internet")

# Join the two datasets by the selected identifiers
math_por <- inner_join(math, por, by = join_by, suffix=c(".math", ".por"))

# Explore the joined dataset
dim(math_por)
str(math_por)


# Create a new data frame with only the joined columns
alc <- select(math_por, one_of(join_by))

# the columns in the datasets which were not used for joining the data
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]

  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

# Define a new column alc_use by combining weekday and weekend alcohol use
alc <- mutate(alc, alc_use=(Dalc + Walc) / 2)

# Define a new logical column 'high_use'
alc <- mutate(alc, high_use = alc_use > 2)

# Check the structure of the dataset
dim(alc)
# [1] 382  35
glimpse(alc)

write.csv(alc, "alc.csv", row.names = FALSE)
