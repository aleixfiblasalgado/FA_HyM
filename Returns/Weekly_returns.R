# Computation of weekly Returns
## To compare with our excel computation of Beta

source("../Importer.R")
wk <- data.HyM
HyM.weekly <- to.weekly(wk)
HyM.weekly <- HyM.weekly[ ,6]
HyM.weekly$Ret <- Delt(HyM.weekly$wk.Adjusted)
HyM.weekly <- HyM.weekly[-1, 2]
HyM.weekly$Ret <- HyM.weekly$Ret*100