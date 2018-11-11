# Boris Vassilev
# 2018-11-11
# 2. Regression and model validation: Exercise 2, Data Wrangling
# read the data into memory
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

# look at the dimensions of the data
dim(lrn14)
# --> there are 183 observations and 60 variables

# look at the structure of the data
str(lrn14)
# --> of the 60 variables, 59 are integers;
#     the last one is a factor with 2 levels,
#     F and M (female and male)

# divide each number in a vector
c(1,2,3,4,5) / 2

# print the "Attitude" column vector of the lrn14 data
lrn14$Attitude

# divide each number in the column vector
lrn14$Attitude / 10

# create column 'attitude' by scaling the column "Attitude"
lrn14$attitude <- lrn14$Attitude / 10

