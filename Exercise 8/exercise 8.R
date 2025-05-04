# Load libraries
library(tidyverse) #install.packages("tidyverse")
library(forcats) #install.packages("forcats")

# Load dataset
rdt <- read_csv("/home/vzscyborg/datasets/pima-indians-diabetes.csv")

# Convert 'Pregnancies' into categorical bins using forcats::fct_collapse
rdt <- rdt %>%
  mutate(Pregnancy_Group = case_when(
    Pregnancies <= 3 ~ "Low",
    Pregnancies > 3 & Pregnancies <= 6 ~ "Medium",
    Pregnancies > 6 ~ "High",
    TRUE ~ NA_character_
  )) %>%
  mutate(Pregnancy_Group = as.factor(Pregnancy_Group))

# Check the counts
rdt %>%
  count(Outcome, Pregnancy_Group)

# Chi-square test
chi_test_result <- rdt %>%
  filter(!is.na(Pregnancy_Group)) %>%
  count(Outcome, Pregnancy_Group) %>%
  pivot_wider(names_from = Pregnancy_Group, values_from = n, values_fill = 0) %>%
  column_to_rownames("Outcome") %>%
  as.matrix() %>%
  chisq.test()

# Print result
print(chi_test_result)
