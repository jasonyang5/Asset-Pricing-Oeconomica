library(tidyverse)
library(feather)

basepath = "~/Documents/oeconomica/Asset-Pricing-Oeconomica/capm_replication/"
returns_data = read_feather(paste0(basepath, "clean_returns_data.feather"))

summary_data = summarise(returns_data, firstdate = min(Date), lastdate = max(Date))

# Beta Calculation --------------------------------------------------------
# beta of a is cov(a,b) / var(b)

# we will be calculating historical beta for all securities before 
# from the start date (Dec 1925) to beginning of analysis (Jan 1935)
# this will give us a rough approximation of the beta

# (in principle, the beta would have to update each month, but that's
# a lot of computational work)

beta_start = 192512
start_date = 193501
end_date = 201806

# change dates to only include months
returns_data = mutate(returns_data, Date = floor(Date / 100))
beta_returns_data = filter(returns_data, Date >= beta_start, Date < start_date)

# calculate beta by stock ID
betadata = group_by(beta_returns_data, ID) %>%
  summarise(cov_w_mkt = cov(Return, MktReturn, use = "complete.obs"),
            mkt_var = var(MktReturn, na.rm = TRUE),
            beta = cov_w_mkt / mkt_var)

# invalidate betas that don't have enough data- i.e. we don't have enough
# observations
