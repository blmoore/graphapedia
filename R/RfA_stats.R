WSC_RfA <- read.delim("~/other/graphapedia/data/WSC_RfA.tsv", header=T)
library(reshape2)
library(zoo)
rfa <- melt(WSC_RfA)
rfa[,1] <- as.yearmon(gsub("X","",paste(rfa[,1], rfa[,2])))
rfa[,2] <- NULL
#plot(rfa, type="l")

autocorr <- acf(na.omit(rfa[,2]), demean=T)
svg("rfa_autocorr.svg", 6,8)
par(mar=c(5,4,2,2), mgp=c(2,0.5,0), mfcol=c(2,1))
plot(autocorr, ylab="Autocorrelation", xlab="Lag (months)", frame=F,
     ylim=c(0,1.05), xlim=c(0,18), col="navy", type="h", yaxs="i", ci.type="ma",
     main="", cex.main=0.8)
title(main="2002-2008", mgp=c(0,1,0))
points(seq(0,21),autocorr$acf, type="b", pch=20)
legend("topright", bty="n", lty=2, col="blue", legend="Moving average C.I.")

# Just since decline (2008)
rfa_latest <- rfa[rfa$X > as.yearmon("Dec 2007"),]
a2 <- acf(rfa_latest[,2], plot=F)
plot(a2, ylab="Autocorrelation", xlab="Lag (months)", frame=F,
     ylim=c(0,1.05), xlim=c(0,12), col="maroon", type="h", yaxs="i", ci.type="ma",
     main="", cex.main=0.8)
points(seq(0,17),a2$acf, type="b", pch=20)
title(main="2008-2012", mgp=c(0,1,0))
dev.off()