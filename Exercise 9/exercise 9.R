# Load the dataset
rdt <- read.csv("/home/vzscyborg/datasets/pima-indians-diabetes.csv")

# Perform One-Way ANOVA for Pregnancies across Outcome groups
anova_result <- aov(Pregnancies ~ as.factor(Outcome), data = rdt)

# Print the summary of the ANOVA test
summary(anova_result)


# Convert Glucose to categories
rdt$Glucose_Group <- cut(rdt$Glucose,
                         breaks = c(-Inf, 100, 140, Inf),
                         labels = c("Low", "Medium", "High"))

# Perform Two-Way ANOVA
anova_two_way <- aov(Pregnancies ~ as.factor(Outcome) * Glucose_Group, data = rdt)

# Print the summary of the ANOVA test
summary(anova_two_way)


# Tukey's HSD test for post-hoc analysis
tukey_result <- TukeyHSD(anova_result)

# Print the Tukey test result
print(tukey_result)

