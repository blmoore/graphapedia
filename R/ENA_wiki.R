#EMBL-Bank Growth
library(zoo)
library(sfsmisc)
svg("figs/EMBLBank_growth3.svg", 6, 6)
options(scipen=3)
par(mar=c(2.5,4.1,2.5,2.1), xaxs="r", lend=2)
ebg <- as.data.frame(read.table("data/EMBLBankGrowth.fixedWidth", header=T, quote="\"", 
                                colClasses=c("numeric", "character","numeric", "numeric")))
ebg[,2] <- as.yearmon(gsub("/", "-", ebg[,2]), "%m-%Y")
plot(ebg[,2], ebg[,4], type="l", log="y", col="blue", lwd=2, xlab="", 
     ylab="Number of Entries or Nucleotides", yaxt="n", xaxt="n", 
     ylim=c(min(ebg[,3]), 1E12), xlim=c(1982,2013), main="Growth of EMBL-Bank (1982-2012)")
axis(2,at=axTicks(2),label=axTexpr(2))
axis(1, at=seq(1980,2015,5))
grid(lty=1)
points(ebg[,2], ebg[,3], type="l", log="y", col="red", lwd=2)
legend("topleft", fill=c("blue","red"), legend=c("Nucleotides", "Entries"), cex=0.8)
dev.off()