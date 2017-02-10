#Quang Minh Nguyen
#February 9, 2017
#Creating alc data from two datasets

student_mat <- read.csv("/Users/nguyenminhquang/Desktop/IODS-project/data/student-mat.csv", sep = ";" , header = TRUE)
student_por <- read.csv("/Users/nguyenminhquang/Desktop/IODS-project/data/student-por.csv", sep = ";" , header = TRUE)
str(student_mat)
str(student_por)
dim(student_mat)
dim(student_por)

#joining the two datasets together
library(dplyr)
library(ggplot2)
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")
math_por <- inner_join(student_mat, student_por, by = join_by, suffix = c(".math", ".por"))
str(math_por)
dim(math_por)

#combining duplicated answers
alc <- select(math_por, one_of(join_by))
notjoined_columns <- colnames(student_mat)[!colnames(student_mat) %in% join_by]
print(notjoined_columns)

for(column_name in notjoined_columns) {
  two_columns <- select(math_por, starts_with(column_name))
  first_column <- select(two_columns, 1)[[1]]
  
  if(is.numeric(first_column)) {
    alc[column_name] <- round(rowMeans(two_columns))
  } else 
    alc[column_name] <- first_column
}

#alc_use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

#high_use
alc <- mutate(alc, high_use = (alc_use > 2))


glimpse(math_por)
glimpse(alc)

write.csv(math_por, file = "/Users/nguyenminhquang/Desktop/IODS-project/data/math_por.csv")
write.csv(alc, file = "/Users/nguyenminhquang/Desktop/IODS-project/data/alc.csv")