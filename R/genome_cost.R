library("ggplot2")
library("scales")
library("reshape2")
library("zoo")

# from http://www.genome.gov/pages/der/sequencing_cost_apr13.xls
seq <- read.table("data/sequencing_costs_apr2014.csv", stringsAsFactors=F, header=T, sep=",")
seq$CostperMb <- NULL

seq <- melt(seq, 1)
seq$Date <- as.yearmon(seq$Date, format="%b-%y")

options(scipen=99)
svg("figs/genome_cost.svg", 5, 4.5)
ggplot(seq, aes(x=as.Date(Date), y=value)) +
  labs(y="Cost per genome (USD)", x="", col="") +
  geom_hline(yintercept=1000, linetype="dashed", 
             col=I(muted("red"))) + 
  geom_line(size=1.5, col=I(muted("blue"))) + 
  scale_y_log10(limits=c(900,100000000),
                breaks=c(1e3, 1e4, 1e5, 1e6, 1e7, 1e8),
                labels=comma) +
  ggtitle("Genome sequencing cost as estimated by NHGRI\n(September 2001 to April 2014)") +
  theme(plot.title=element_text(size=12))
dev.off()
