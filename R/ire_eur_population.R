# Ireland / Europe

## Data from exiting figure annotation:
# Numbers (millions) estimated from previous versions. 
ireland <- "1745 2.8  
1755 3.2  
1765 3.5  
1775 3.6  
1785 4  
1795 4.8  
1805 5.2  
1815 6  
1825 6.8  
1835 7.8  
1845 8.2  
1855 6.9  
1865 5.8  
1875 5.4  
1885 5.2  
1895 4.7  
1905 4.5  
1915 4.4  
1925 4.4  
1935 4.1  
1955 4.4  
1965 4.2  
1975 4.5  
1985 4.9  
1995 5.1  
2005 5.5"

europe <- "1755 165  
1805 204  
1855 283  
1905 412  
1955 550  
1965 607  
1975 659  
1985 692  
1995 723  
2005 730"

eu <- cbind(read.table(text=europe), area="Europe")
ir <- cbind(read.table(text=ireland), area="Ireland")

dat <- rbind(eu, ir)
colnames(dat) <- c("Year", "Population", "Area")

## ggplot version
ggplot(dat, aes(x=Year, y=Population, col=Area)) +
  geom_line() + facet_wrap(~Area, scales="free_y", ncol=1)

## r-base version
svg("figs/ire_eur_pop.svg", 6, 4.5)
par(mar=c(2.5,4,1,5), mgp=c(2,.65,0))
plot(eu[,1:2], type="n", col="darkblue", axes=F, 
     ylim=c(0,920), xlim=c(1740, 2006), xlab="", ylab="")
grid()
lines(eu[,1:2], lwd=2, col="darkblue")
points(eu[,1:2], pch=20, cex=1.2, col="darkblue")
axis(1, at=seq(1720, 2020, by=20), cex.axis=.8)
axis(4, at=seq(0,900, by=100), las=1)
axis(2, at=seq(0,900, by=100), labels=0:9, las=1)
lines(ir[,1], ir[,2]*100, col="darkgreen", lwd=2)
points(ir[,1], ir[,2]*100, pch=20, cex=1.2, col="darkgreen")
mtext("Population of Ireland (millions)", 2, line=2, col="darkgreen")
mtext("Population of Europe (millions)", 4, line=3, col="darkblue")
legend("top", bty="n", legend=c("Ireland", "Europe"), 
       col=c("darkgreen", "darkblue"), lty=1, lwd=2, horiz=T, pch=20)
dev.off()

