# Load data
rdt <- read.csv("/home/vzscyborg/datasets/pima-indians-diabetes.csv")
df <- rdt[, 1:8]  # i used only first 8 columns
target <- rdt$Outcome  #dependent variable for regression

#mode function
getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}

#summary data frame
summary_table <- data.frame(
  Feature = character(),
  Mean = numeric(),
  Median = numeric(),
  Mode = numeric(),
  SD = numeric(),
  Correlation = numeric(),
  Regression_Slope = numeric(),
  stringsAsFactors = FALSE
)

# Loop over columns
for (colname in colnames(df)) {
  col_data <- df[[colname]]
  
  mean_val <- mean(col_data, na.rm = TRUE)
  median_val <- median(col_data, na.rm = TRUE)
  mode_val <- getmode(col_data)
  sd_val <- sd(col_data, na.rm = TRUE)
  cor_val <- cor(col_data, target, use = "complete.obs")
  
  # Linear regression slope (simple)
  lm_model <- lm(target ~ col_data)
  slope <- coef(lm_model)[2]
  
  # Append to summary table
  summary_table <- rbind(summary_table, data.frame(
    Feature = colname,
    Mean = mean_val,
    Median = median_val,
    Mode = mode_val,
    SD = sd_val,
    Correlation = cor_val,
    Regression_Slope = slope
  ))
}
print(summary_table, row.names = FALSE)
