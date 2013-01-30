library(zoo)
wiki <- read.delim("~/Desktop/wiki.stats", header=F)
par(mar=c(2,4.5,1,2))
#svg("~/Desktop/wiki_stats.svg",7,7 )
wiki[,1] <- as.yearmon(wiki[,1],"%b %Y")
# Active (10 edits / month)
plot(wiki[,1], wiki[,4], type="l", xaxt="n", ylab="Number of editors", lwd=4,
     col="darkblue", xlab="")
# Really active (100 edits / month)
points(wiki[,1], wiki[,5], type="l", lwd=4, col="darkgreen")
axis(1, at=seq(2001,2012,1), cex.axis=0.8)
legend("topleft", c("10 edits / month", "100 edits / month"), col=c("darkblue","darkgreen"), bty="n",
       lwd=4)

# From 2007:
library(car)
recent  <- wiki[wiki[,1] > 2007,]
reg <- lm(recent[,4] ~ recent[,1])
regLine(reg, lwd=2)
text(2011,45000,paste("~", signif(abs(reg$coefficients[[2]]),2), " fewer per year", sep=""), col="darkblue")
text(2011,43000,paste(signif(abs(reg$coefficients[[2]]) / max(recent[,4]) * 100,3), "% of max.", sep=""), col="darkblue")

reg2 <- lm(recent[,5] ~ recent[,1])
regLine(reg2, lwd=2, col="black")
text(2011,10000,paste("~", signif(abs(reg2$coefficients[[2]]),2), " fewer per year", sep=""), col="darkgreen")
text(2011,8000,paste(signif(abs(reg2$coefficients[[2]]) / max(recent[,5]) * 100,3), "% of max.", sep=""), col="darkgreen")
#dev.off()

#dev.off()
admin.dat <- read.table("~/Desktop/admin.stats", quote="\"")
admin <- cbind(wiki[wiki[,1] > as.yearmon("Dec 2007"),], rev(admin.dat[,1]))
require(Hmisc) 
subplot(function(){
  plot(admin[,5], admin[,21], pch=20, col="maroon", ylab="", xlab="", 
             axes=F, frame=T);
  }
        ,2002,20000, size=c(1.5,1.5))
cor(admin[,21], admin[,5])
cor(admin[,4], admin[,21])
#