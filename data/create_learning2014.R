#### 1. Data wrangling (max 5 points)
#Name: Quang M Nguyen
#Date: 3 Feb 2017
#Description: Data wrangling 

getwd()

#### 2. (1 point)

learning2014 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)
dim(learning2014)
str(learning2014)

#### 3.  (1 point)
library(dplyr)
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

deep_columns <- select(learning2014, one_of(deep_questions))
learning2014$deep <- rowMeans(deep_columns)

surface_columns <- select(learning2014, one_of(surface_questions))
learning2014$surf <- rowMeans(surface_columns)

strategic_columns <- select(learning2014, one_of(strategic_questions))
learning2014$stra <- rowMeans(strategic_columns)

keep_columns <- c("gender", "Age","Attitude", "deep", "stra", "surf", "Points")
str(learning2014)
learn2014 <- select(learning2014, one_of(keep_columns))

learn2014 <- filter(learn2014, Points > 0)
str(learn2014)
dim(learn2014)
variable.names(learn2014)
write.csv(learn2014, file = "/Users/nguyenminhquang/Desktop/IODS-project/data/learn2014.csv")

#### 4.  (3 points)
learning2014 <- read.csv(file = "/Users/nguyenminhquang/Desktop/IODS-project/data/learn2014.csv", sep = "," , header = TRUE, fill = TRUE, quote = "\"", dec = ".")
learning2014$X <- NULL
summary(learning2014)
str(learning2014)
head(learning2014)
