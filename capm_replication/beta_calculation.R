library(tidyverse)
library(feather)

basepath = "~/Documents/oeconomica/Asset-Pricing-Oeconomica/capm_replication/"
returns_data = read_feather(paste0(basepath, "clean_returns_data.feather"))

# Beta Calculation --------------------------------------------------------
# beta of a wrt market b by definition is covariance(a,b) / variance(b)

# we will be calculating historical beta for all securities before 
# from the start date (Dec 1925) to beginning of analysis (Jan 1935)

beta_start = 192512
start_date = 193501
end_date = 201806

# change dates to only include months
returns_data = mutate(returns_data, Date = floor(Date / 100))
beta_returns_data = filter(returns_data, Date >= beta_start, Date < start_date)

# remove ID's that don't have enough historical returns data:
# beta_start minus start date # of months
years_desired = 9
beta_returns_data = group_by(beta_returns_data, ID) %>%
  mutate(num_entries = n())
excluded_ids = filter(beta_returns_data, num_entries < years_desired * 12) %>%
  select(ID)
beta_returns_data = filter(beta_returns_data, num_entries >= years_desired * 12)

# calculate beta by stock ID
betadata = group_by(beta_returns_data, ID) %>%
  summarise(cov_w_mkt = cov(Return, MktReturn, use = "complete.obs"),
            mkt_var = var(MktReturn, na.rm = TRUE),
            beta = cov_w_mkt / mkt_var)

# write out betas, excluded IDs
write.csv(betadata, paste0(basepath, "betas.csv"))
write.csv(excluded_ids, paste0(basepath, "nobeta_IDs.csv"))