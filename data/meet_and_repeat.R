# Boris Vassilev
# 2018-12-09

library(dplyr)
library(tidyr)

# BPRS
BPRS <- read.csv("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", stringsAsFactors = F, header = T, sep = " ")

RATS <- read.csv("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", stringsAsFactors = F, sep = "\t", header = T)

dim(BPRS)
dim(RATS)
str(BPRS)
str(RATS)
summary(BPRS)
summary(RATS)

BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)


# Convert to long form
########################

BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks, 5, 5)))
glimpse(BPRSL)

# RATS
RATSL <-  RATS %>% gather(key = WD, value = Weight, -ID, -Group)
RATSL <-  RATSL %>% mutate(Time = as.integer(substr(WD, 3, 4)))
glimpse(RATSL)

# Write datasets to file
write.csv(BPRSL, "data/BPRSL.csv")
write.csv(RATSL, "data/RATSL.csv")
