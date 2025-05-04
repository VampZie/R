library(BSDA)

rdt <- read.csv("/home/vzscyborg/datasets/pima-indians-diabetes.csv")
print(summary(rdt$SkinThickness))

# One-sample z-test
# Null hypothesis: mean = 30
# Alternative: mean ≠ 30
# Assume population sd = 10 (you can change this!)

z_test_one <- z.test(rdt$SkinThickness,
                     mu = 30,
                     sigma.x = 10,
                     alternative = "two.sided",
                     conf.level = 0.95)

print(z_test_one)


# Split SkinThickness by Outcome (0 and 1)
skin_0 <- na.omit(rdt$SkinThickness[rdt$Outcome == 0])
skin_1 <- na.omit(rdt$SkinThickness[rdt$Outcome == 1])

# Print summary of both groups
cat("Group 0 Summary:\n")
print(summary(skin_0))
cat("Group 1 Summary:\n")
print(summary(skin_1))

# Two-sample z-test
# Assume population SDs for both groups (you can change 10 and 12 to real/population values)
z_test_two <- z.test(skin_0, skin_1,
                     sigma.x = 10,
                     sigma.y = 12,
                     alternative = "two.sided",
                     conf.level = 0.95)

print(z_test_two)
