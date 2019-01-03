library(tidyverse)
library(feather)

basepath = "~/Documents/oeconomica/Asset-Pricing-Oeconomica/capm_replication/"
beta_data = read_csv(paste0(basepath, "betas.csv"))
beta_data = select(beta_data, ID, beta)
returns_data = read_feather(paste0(basepath, "clean_returns_data.feather"))

# join them together
beta_return_data = left_join(returns_data, beta_data)

# Deciles -----------------------------------------------------------------
# divide betas all into deciles
beta_returns_data = mutate(beta_returns_data, decile = ntile(beta, 10))

# run regression

# do plot