# Load dataset
rdt <- read.csv("/home/vzscyborg/datasets/pima-indians-diabetes.csv")

# Get numeric columns (excluding Outcome itself)
numeric_cols <- names(rdt)[sapply(rdt, is.numeric) & names(rdt) != "Outcome"]
# Create empty list to store results
f_test_results <- list()

for (col_name in numeric_cols) {
  group0 <- na.omit(rdt[rdt$Outcome == 0, col_name])
  group1 <- na.omit(rdt[rdt$Outcome == 1, col_name])
  
  if (length(group0) > 1 & length(group1) > 1) {
    f_test <- var.test(group0, group1)
    f_test_results[[col_name]] <- list(
      p_value = f_test$p.value,
      f_statistic = f_test$statistic,
      conf_int = f_test$conf.int
    )
  }
}

# Convert to data frame
f_test_summary <- data.frame(
  Variable = names(f_test_results),
  P_Value = sapply(f_test_results, function(x) x$p_value),
  F_Statistic = sapply(f_test_results, function(x) x$f_statistic)
)

print(f_test_summary)
