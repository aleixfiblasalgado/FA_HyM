# Market capitalization
source("Importer.R")

## Gather data from the anual reports
outstanding_shares <- 1655072000
share.price <- 323.5
Market_capitalization <- share.price * outstanding_shares
print(Market_capitalization)