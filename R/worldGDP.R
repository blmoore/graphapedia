## world GDP
# data: http://www.ggdc.net/maddison/Historical_Statistics/horizontal-file_03-2007.xls
library("ggplot2")
library("reshape2")

gdp <- read.csv("data/historicWorldGDP.csv", 
                skip=2, header=T, na.strings="")

rnames <- c("Total 29 Western Europe",
           "Total Western Offshoots",
           "Total 7 East European Countries",
           "Total Former USSR",
           "Total Latin America",
           "Total Asia",
           "Total Africa",
           "World Average")
cols <- paste0("X", c(1, 1000, 1500, 1600, 1700, 1820, 1900, 2003))

gdp[,1] <- gsub(" $","", as.character(gdp[,1]))
gdf <- gdp[gdp[,1] %in% rnames,]
gdf$X <- c("Western Europe", "Western Offshoots", "Eastern Europe",
           "Former USSR", "Latin America", "Asia", "Africa", "World Average")
gdf <- gdf[,colnames(gdf) %in% c("X", cols)]

gdf <- melt(gdf, id.vars="X")

colnames(gdf) <- c("Area", "Year", "GDP")
gdf$Year <- as.numeric(gsub("X","",gdf$Year))
gdf$GDP <- as.numeric(gsub(",","",gdf$GDP))

svg("figs/worldGDP.svg", 6, 5)
ggplot(gdf, aes(x=Year, y=GDP, col=Area)) +
  geom_line(size=1.2) + geom_point(size=2.5) +
  #geom_bar(stat="identity", position=position_dodge()) +
  coord_cartesian(ylim=c(350, 55000), xlim=c(1400,2010)) +
  scale_y_log10(breaks=c(500,1000,2500,5000,10000,25000,50000)) + theme_bw() +
  scale_color_brewer(type="qual", palette=1, 
                     guide=guide_legend(ncol=2)) +
  theme(legend.position=c(.3,.875), 
        legend.background = element_blank()) +
  labs(list(x="", y="GDP per capita (Geary–Khamis dollars)", col=""))
dev.off()  
