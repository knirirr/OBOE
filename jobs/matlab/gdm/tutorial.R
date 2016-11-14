testenv <- read.csv("GDM_R_Distribution_Pack_V1.1/envdat.csv")
testresp <- read.csv("GDM_R_Distribution_Pack_V1.1/respdat.csv")
mymod <- gdm.fit(testenv, testresp)

