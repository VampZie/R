library(readxl)
rdt <- read.csv("/home/vzscyborg/datasets/pima-indians-diabetes.csv")

colnames(rdt)
rdt$BMI_Group <- ifelse(rdt$BMI < median(rdt$BMI, na.rm = TRUE), "Low", "High")
table(rdt$BMI_Group)
t_test_result <- t.test(BloodPressure ~ BMI_Group , data =rdt)
print(t_test_result)

#grouping the pregnancies into two groups for removing continous variable to TWO value group data
rdt$P_Group <- ifelse(rdt$Pregnancies < median (rdt$Pregnancies, na.rm = TRUE), "Low","High")
#F test 
f_test_result <- var.test(BloodPressure ~ P_Group, data = rdt)
print(f_test_result)


# Extract the variance ratio (F-statistic)
variance_ratio <- f_test_result$statistic
print(variance_ratio)

# ANOVA to test mean BloodPressure differences across Preg_Group
anova_result <- aov(BloodPressure ~ P_Group, data = rdt)
summary(anova_result)

#Boxplot of anova
boxplot(BloodPressure ~ P_Group, data = rdt,
        main = "Blood Pressure by Pregnancy Group",
        xlab = "Pregnancy Group", ylab = "Blood Pressure")

