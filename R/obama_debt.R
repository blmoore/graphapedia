##debt

## 1) http://www.treasurydirect.gov/govt/reports/pd/histdebt/histdebt_histo5.htm
table <- "09/30/2012	16,066,241,407,385.89
09/30/2011	14,790,340,328,557.15
09/30/2010	13,561,623,030,891.79
09/30/2009	11,909,829,003,511.75
09/30/2008	10,024,724,896,912.49
09/30/2007	9,007,653,372,262.48
09/30/2006	8,506,973,899,215.23
09/30/2005	7,932,709,661,723.50
09/30/2004	7,379,052,696,330.32
09/30/2003	6,783,231,062,743.62
09/30/2002	6,228,235,965,597.16
09/30/2001	5,807,463,412,200.06
09/30/2000	5,674,178,209,886.86"

options(scipen=99)
setAs("character", "num.with.commas", 
      function(from) as.numeric(gsub(",", "", from) ) )
td <- read.table(text=table, colClasses=c("character", "num.with.commas"))
colnames(td) <- c("Date", "Value")
td$Date <- gsub(".*/", "", td$Date)
difference <- data.frame(Date=td$Date[-nrow(td)],
                         Value=diff(td$Value)/1e9, type="Increase in debt")

# 2) deficit, data from http://www.cbo.gov/publication/43904
def = "2001	128.2
2002	-157.8
2003	-377.6
2004	-412.7
2005	-318.3
2006	-248.2
2007	-160.7
2008	-458.6
2009	-1,412.7
2010	-1,293.5
2011	-1,295.6
2012	-1,089.4"

defi <- read.table(text=def, colClasses=c("character", "num.with.commas"))
colnames(defi) <- c("Date", "Value")
defi$type <- "Total budget deficit"
# convert both to billions
defi$Value <-  defi$Value

df <- rbind(difference, defi)

# recreate original (confusing? table):

p <- ggplot(df, aes(x=Date, y=Value*-1, fill=type)) + 
  geom_bar(stat="identity", position=position_dodge()) +
  theme_bw() + theme(legend.position = c(0.2, 0.8),
  legend.background = element_rect(fill = "#ffffffaa", colour = NA)) +
  labs(y="Amount in billions of USD", xlab="", fill="") + xlab("") +
  scale_fill_brewer(type="qual", palette=3)

ggsave(filename="Obama_debt_originalplot.pdf", p)

### improved:
source("obama_debt_data.R")
d <- read.table("~/other/graphapedia/data/us_debt.tsv", 
                sep="\t", header=TRUE)
colnames(d) <- c("public", "inter", "total")
d$public <- NULL
d$inter <- NULL
d$date <- as.Date(rownames(d), format="%m/%d/%Y")

head(d)

ggplot(d, aes(x=date, y=total/1e9)) +
  geom_line() + ylab("Total public debt (U")
