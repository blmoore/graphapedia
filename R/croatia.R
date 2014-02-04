# data from: http://www.johnstonsarchive.net/policy/abortion/ab-croatia.html
cro <- read.table("~/other/graphapedia/data/croatia_birthsdat.tsv")
colnames(cro) <- c("Year", "Live births", "Reported abortions")
df <- melt(cro, "Year")

svg("croatia.svg", 6, 5)
ggplot(df, aes(x=Year, y=value/1e3, col=variable)) +
  geom_line(size=1.3) + ylab("Number recorded per year (000s)") +
  theme_bw() + theme(legend.position = c(0.2, 0.2),
  legend.background = element_rect(fill = "#ffffffaa", colour = NA),
                     legend.text=element_text(size=12)) +
  labs(x="", col="")
dev.off()
