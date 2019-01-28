library(tidyverse)
library(feather)

basepath = "~/Documents/oeconomica/Asset-Pricing-Oeconomica/capm_replication/"
beta_data = read_csv(paste0(basepath, "betas.csv"))
beta_data = select(beta_data, ID, beta)
returns_data = read_feather(paste0(basepath, "clean_returns_data.feather"))

# join them together
beta_return_data = left_join(returns_data, beta_data)

# Deciles -----------------------------------------------------------------
# divide betas all into deciles and add mkt cap
beta_return_data = mutate(beta_return_data, Decile = ntile(beta, 10),
                          MktCap = Price * ShsOutstand)
beta_return_data = filter(beta_return_data, !is.na(beta), !is.na(MktCap), !is.na(Return))

# summarise what the beta buckets look like
beta_summary_stats = group_by(beta_return_data, Decile) %>%
  summarise(avg_beta = mean(beta),
            standard_dev = sd(beta),
            max_beta = max(beta),
            min_beta = min(beta),
            avg_mk_cap = mean(ShsOutstand * mean(Price, na.rm = TRUE), na.rm = TRUE))

# market cap vs beta decile
mkcap_vs_beta_dec = ggplot(beta_summary_stats, aes(x = decile, avg_mk_cap)) +
  geom_col()

# Portfolio ---------------------------------------------------------------
# need to change the beta returns data so we have an average return
# weighted by market cap for each date observation
decile_return_data = group_by(beta_return_data, Decile, Date) %>%
  summarise(weighted_return = weighted.mean(Return, MktCap)) %>%
  mutate(weighted_return = weighted_return + 1)

# starting with $10,000 in 1935 for each beta bucket
# see the value of the portfolio over time
make_portfolio <- function(decile)
{
  portfolio_decile = filter(decile_return_data, Decile == decile)
  portfolio_decile = mutate(portfolio_decile, 
                            portfolio_value = cumprod(weighted_return))
  return(portfolio_decile)
}

portfolio_list = lapply(1:10,
                        make_portfolio)

portfolio_data = bind_rows(portfolio_list)

write_feather(portfolio_data, paste0(basepath, "portfolio_sim.feather"))
