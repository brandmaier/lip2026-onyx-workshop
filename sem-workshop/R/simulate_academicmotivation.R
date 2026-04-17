set.seed(123)

# Sample size
N <- 500

# Latent factor
eta <- rnorm(N, mean = 0, sd = 1)

# Factor loadings
lambda <- c(0.8, 0.7, 0.75, 0.8, 0.7)

# Residual covariance matrix
#Theta <- matrix(0, nrow = 5, ncol = 5)
Theta <- lambda%*%t(lambda)
diag(Theta) <- 1#-lambda^2  # residual variances

# Add substantial residual correlation between y4 and y5
resid_cor_45 <- 0.40
Theta[4, 5] <- Theta[4, 5]+resid_cor_45 * sqrt(Theta[4, 4] * Theta[5, 5])
Theta[5, 4] <- Theta[4, 5]

# Generate residuals
library(MASS)
E <- MASS::mvrnorm(n = N, mu = rep(0, 5), Sigma = Theta)

cor(E)

# Put into a data frame
dat <- as.data.frame(Y)
names(dat) <- paste0("y", 1:5)

# Inspect correlations
round(cor(dat), 2)

names(dat) <- c(
"persistence_on_tasks",
"time_spent_studying",
"curiosity_about_topics",
"interest_in_subject",
"enjoyment_of_learning")

write.csv(dat, "sem-workshop/data/academicmotivation.csv")