library("dplyr")
library("ggplot2")

ys <- read.csv("http://www.quake.utah.edu/EQCENTER/LISTINGS/Catalogs/Yell_UUUS_c.csv")

svg("~/other/graphapedia/figs/yellowstone_earthquakes.svg", 6, 4)
ys %>% group_by(year) %>% filter(year > 1972) %>%  tally() %>%
  ggplot(data=., aes(x=year, y=n)) + 
  geom_bar(stat="identity") +
  labs(x="Year", y="Number of earthquakes") + 
  scale_y_continuous(expand=c(0,0), limits=c(0, 3500)) +
  scale_x_continuous(expand=c(0,0.2)) +
  theme_bw() +
  ggtitle("Earthquakes in Yellowstone National Park region (1973-2014)")
dev.off()
