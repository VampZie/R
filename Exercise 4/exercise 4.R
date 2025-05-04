# Load necessary libraries
library(psych) #install.packages("psych")
library(dplyr)

# Read the dataset
rdt <- read.csv("/home/vzscyborg/datasets/pima-indians-diabetes.csv")

# -----------------------------
# 1️⃣ Overall summary statistics
# -----------------------------
cat("---- Overall Summary ----\n")
print(summary(rdt))

# -----------------------------
# 2️⃣ Summary of BloodPressure
# -----------------------------
cat("\n---- BloodPressure Summary ----\n")
print(summary(rdt$BloodPressure))
cat("Mean:", mean(rdt$BloodPressure, na.rm = TRUE), "\n")
cat("Median:", median(rdt$BloodPressure, na.rm = TRUE), "\n")
cat("Standard Deviation:", sd(rdt$BloodPressure, na.rm = TRUE), "\n")
cat("Variance:", var(rdt$BloodPressure, na.rm = TRUE), "\n")
cat("Min:", min(rdt$BloodPressure, na.rm = TRUE), "\n")
cat("Max:", max(rdt$BloodPressure, na.rm = TRUE), "\n")

# ------------------------------------
# 3️⃣ Detailed descriptive stats (psych)
# ------------------------------------
cat("\n---- Detailed Descriptive Stats ----\n")
print(describe(rdt))

# ------------------------------------
# 4️⃣ Group-wise summary (Preg_Group)
# ------------------------------------
# Create Preg_Group based on median Pregnancies
rdt$Preg_Group <- ifelse(rdt$Pregnancies < median(rdt$Pregnancies, na.rm = TRUE), "Low", "High")

cat("\n---- Group Sizes ----\n")
print(table(rdt$Preg_Group))

cat("\n---- Group-wise Summary ----\n")
print(aggregate(BloodPressure ~ Preg_Group, data = rdt, FUN = summary))

# Group-wise mean & SD using dplyr
cat("\n---- Group-wise Mean & SD ----\n")
group_summary <- rdt %>%
  group_by(Preg_Group) %>%
  summarise(
    count = n(),
    mean_BP = mean(BloodPressure, na.rm = TRUE),
    sd_BP = sd(BloodPressure, na.rm = TRUE),
    median_BP = median(BloodPressure, na.rm = TRUE),
    min_BP = min(BloodPressure, na.rm = TRUE),
    max_BP = max(BloodPressure, na.rm = TRUE)
  )
print(group_summary)

# ------------------------------------
# 5️⃣ Correlation between BloodPressure & BMI
# ------------------------------------
cat("\n---- Correlation (BloodPressure vs BMI) ----\n")
corr_value <- cor(rdt$BloodPressure, rdt$BMI, use = "complete.obs")
print(corr_value)

# ------------------------------------
# 6️⃣ Visual summaries
# ------------------------------------
# Boxplot of BloodPressure
boxplot(rdt$BloodPressure,
        main = "Boxplot of Blood Pressure",
        ylab = "Blood Pressure")

# Histogram of BloodPressure
hist(rdt$BloodPressure,
     main = "Histogram of Blood Pressure",
     xlab = "Blood Pressure",
     col = "lightblue", border = "black")
