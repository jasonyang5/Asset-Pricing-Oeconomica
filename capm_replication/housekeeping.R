library(tidyverse)
library(feather)

basepath = "~/Documents/oeconomica/Asset-Pricing-Oeconomica/capm_replication/"

return_data = read_feather(paste0(basepath, "returns_data.feather"))
riskfree_data = read_csv(paste0(basepath, "rf_data.csv")) %>%
  select(X1, RF)

# General Housekeeping ----------------------------------------------------
# Remove irrelevant columns, rename columns
return_data = select(return_data, -PERMCO)
new_names = c("ID", "Date", "Exchange", "Ticker", "DelistDate", "DelistReturn",
              "Price", "Return", "ShsOutstand", "MktReturn", "SPReturn")
colnames(return_data) = new_names
rm(new_names)

colnames(riskfree_data) = c("RiskFree_Date", "RiskFree")

# interpret return as numbers, not characters
return_data = mutate(return_data, Return = as.character(Return)) %>%
  mutate(Return = as.numeric(Return))

# basic summary stats to refer to
summary_stats = summarise(return_data, 
                          maxreturn = max(Return, na.rm = TRUE),
                          minreturn = min(Return, na.rm = TRUE),
                          start_date = min(Date, na.rm = TRUE),
                          end_date = max(Date, na.rm = TRUE))

# attach risk free rate to return data
return_data = mutate(return_data, 
                      RiskFree_Date = floor(Date/100)) %>%
  left_join(riskfree_data) %>%
  select(-RiskFree_Date)

# add excess return- return minus risk free return
return_data = mutate(return_data, ExcessReturn = Return - RiskFree)

write_feather(return_data, path = paste0(basepath, "clean_returns_data.feather"))

# Beta Buckets ------------------------------------------------------------



# Regression --------------------------------------------------------------



# Visualisation -----------------------------------------------------------


