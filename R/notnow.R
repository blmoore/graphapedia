library("ggplot2")
library("plyr")
library("gridExtra")
setwd("~/other/graphapedia/")
rfa <- read.table("data/unsucc_rfas.tsv", 
                  header=F, sep="\t", stringsAsFactors=F)
colnames(rfa) <- c("Username", "Date", "ClosedAs", "Closer", "Tally")

rfa$Date <- as.Date(rfa$Date, format="%d %B %Y")
rfa$Month <- cut(rfa$Date, "months")
rfa$reason <- ifelse(grepl("SNOW|NOTNOW", rfa$ClosedAs), "NOTNOW/SNOW", "Other")

summary <- ddply(rfa, .(Month, reason), summarise, Number=length(Username))

svg("figs/notnow.svg", 10, 4.5)
grid.arrange(
ggplot(summary, aes(x=Month, y=Number, fill=reason)) +
  geom_bar(stat="identity") + theme_classic() +
  theme(axis.text.x=element_text(angle=90, vjust=.5, size=6),
        legend.position=c(.8,.8),
        legend.background=element_blank()) +
  scale_y_continuous(expand=c(0,0)) +
  labs(list(y="Number of unsuccesful RfAs per month", x="", fill="Reason"))
,
ggplot(summary, aes(x=reason, y=Number, fill=reason)) +
  geom_violin() + theme_bw() +
  theme(legend.position="none") +
  labs(list(y="Number of unsuccesful RfAs per month", x="", fill="Reason")) +
  geom_segment(x=.5, xend=1.5, y=4, yend=4) +
  annotate("text", x=1, y=4.2, label="This month NOTNOW", size=3.5)
, ncol=2)
dev.off()

obs <- density(summary$Number, from=0)
exp <- density(rpois(200, mean(summary$Number)), from=0)
plot(obs, type="l", ylim=c(0,.2), col="darkgreen")
# Does theoretical dist look anything like expected?
lines(exp, col="darkred")
# looks OK
qqplot(summary$Number, rpois(200, mean(summary$Number)))

dpois(4, mean(summary$Number))

median(summary$Number)
