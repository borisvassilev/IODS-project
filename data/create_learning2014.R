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

# print the "Attitude" column vector of the lrn14 data
lrn14$Attitude

# divide each number in the column vector
lrn14$Attitude / 10

# create column 'attitude' by scaling the column "Attitude"
lrn14$attitude <- lrn14$Attitude / 10

# Access the dplyr library
library(dplyr)

# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select the columns related to deep learning and create column 'deep' by averaging
deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)

# select the columns related to surface learning and create column 'surf' by averaging
surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)

# select the columns related to strategic learning and create column 'stra' by averaging
strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)

# choose a handful of columns to keep
keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")

# select the 'keep_columns' to create a new dataset
learning2014 <- select(lrn14, one_of(keep_columns))
# exclude observations where Points variable is 0
learning2014 <- filter(learning2014, Points != 0)

# see the stucture of the new dataset
dim(learning2014)
# --> 166 observations of 7 variables
str(learning2014)
# --> looks fine. Unclear why to normalize.

learning2014 <- rename(learning2014, age = Age, points = Points)
colnames(learning2014)
# --> successfully renamed two columns

write.table(learning2014, file = "data/learning2014.tsv", sep = "\t")

learning2014.from_saved <- read.table("data/learning2014.tsv", sep = "\t")
dim(learning2014.from_saved)
str(learning2014.from_saved)
head(learning2014.from_saved)
