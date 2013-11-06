# relative path if sourced with master.R
a <- read.table("../data/wvotes.tsv", fill=T, stringsAsFactors=F, header=T)

# format messy string into date
a$Firstedit <- as.Date(a$Firstedit, "%B_%d,_%Y")

# Do support/oppose levels differ between admins and non-admins?
ggplot(a, aes(x=Opposes, y=Supports, col=Admin, group=Admin)) + 
  geom_jitter(width=4, height=4) + geom_smooth(method="lm", se=F) + theme_bw() 

# Filter users who haven't voted much
b <- a[a$Supports + a$Opposes + a$Neutrals > 10,]
library(gridExtra)
svg("../figs/RfAvote_analysis.svg",15, 5)
grid.arrange(
  # Do those with higher edit counts support more?
  ggplot(b, aes(x=Editcount+1, y=100*(Supports/(Supports+Opposes+Neutrals)), col=Admin)) + 
    geom_jitter() + scale_x_log10() + geom_smooth(method="lm", se=T, size=1.5) + 
    theme_bw() + xlab("Number of edits") + ylab("Support percentage (Users with >10 votes)"),
  # Do old-timers support more than newer editors?
  ggplot(b, aes(x=Firstedit+1, y=100*(Supports/(Supports+Opposes+Neutrals)), col=Admin)) + 
    geom_jitter() + geom_smooth(method="lm", se=T, size=1.5) + 
    theme_bw() + xlab("Date of first edit") + ylab("Support percentage (Users with >10 votes)"),
  # Do admins on the whole support more RfAs than editors?
  ggplot(b, aes(x=Admin, y=100*(Supports/(Supports+Opposes+Neutrals)), fill=Admin)) + 
    geom_violin(alpha=I(.5), notch=T) + xlab("Admin") + theme_bw() +
    ylab("Support percentage (Users with >10 votes)")
  , ncol=3)
dev.off()

#ggplot(a, aes(x=Firstedit, y=100*(Supports/(Supports+Opposes+Neutrals)))) + geom_point()
