library("ggplot2")
library("reshape2")
library("scales")

lev <- read.table("data/IB_leverage.tsv", sep="\t", header=T)
lev <- lev[,c(1:2, 6)]
lev <- melt(lev, c("Bank", "Year"))

svg("figs/leverage.svg", 7.5, 5)
ggplot(lev, aes(x=as.Date(as.character(Year), format="%Y"), y=value, fill=Bank)) +
  geom_bar(stat="identity", position=position_dodge()) +
  scale_y_continuous(limits=c(10,32), oob = rescale_none) +
 # theme(legend.direction="horizontal", legend.position=c(.4,0.9), 
#        legend.background = element_blank()) +
  labs(list(x="", y="Leverage ratio (total debt / stockholders' equity)", fill="")) +
  scale_fill_brewer(type="qual", palette=3) +
  ggtitle("Leverage ratios for major investment banks")

dev.off()
