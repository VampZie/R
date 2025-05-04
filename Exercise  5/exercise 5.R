library(readxl)
rdt <- read.csv("/home/vzscyborg/datasets/pima-indians-diabetes.csv")
colnames(rdt)

boxplot(rdt$Glucose) # to check the outliers

# One-Sample t-test (test if the mean of Glucose is different from 100)
t_test_one_sample <- t.test(rdt$Glucose, mu = 100)
print(t_test_one_sample)


# Two-Sample t-test (Welch’s t-test by default)
t_test_two_sample <- t.test(Glucose ~ Outcome, data = rdt)
print(t_test_two_sample)

# Check and remove NAs
rdt_clean <- rdt[!is.na(rdt$Glucose) & !is.na(rdt$Outcome), ]
hist(rdt$Glucose)
shapiro.test(rdt$Glucose)
var.test(Glucose ~ Outcome, data = rdt)  # F-test for equal variances
