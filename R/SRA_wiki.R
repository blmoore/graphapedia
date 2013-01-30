library(plotrix)
library(sfsmisc)

slices <- c(84, 12, 2, 2) 
lbls <- c("Illumina GA", "SOLiD", "454", "Other")
options(scipen=5)
###########
svg("~/other/SRA_growth3.svg", 6,5)
par(mar=c(2,4,2,2), cex=1)
sra_stat <- read.csv("~/Downloads/sra_stat.csv")
typeof(sra_stat[,1])
#rstudio::viewData(sra_stat)
sra_stat[,1] <- as.Date(sra_stat[,1], format="%m/%d/%Y")
sra_stat <- sra_stat[2:nrow(sra_stat),]
plot(sra_stat[,1], sra_stat[,2], xlab="", ylab="Number of Bases", type="l", log="y", col="darkgreen", 
     lwd=3, yaxt="n")
points(sra_stat[,1], sra_stat[,3], type="l", col="lightgreen", lwd=3)
axis(2,at=axTicks(2),label=axTexpr(2))
legend("topleft", fill=c("darkgreen", "lightgreen"), legend=c("All Bases", "Open Access"))
#par(new=T)
library(TeachingDemos)
#library(Rgraphviz)
par(cex=0.8)
subplot(pie(slices, labels=lbls, main="", col = c(topo.colors(4))), 
        as.Date("2011/07/14"), 5E11, size=c(2.5,2.5))
dev.off()

