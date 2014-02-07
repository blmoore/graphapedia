## y = x^2 (singularity at x=2)
x <- seq(-6,6,by=.1)
y <- x^2

# xy <- data.frame(x=x, y=x^2)
# ggplot(xy, aes(x=x, y=y)) +
#   geom_line()

svg("figs/discontinuous_fx.svg", 5,5)
par(mgp=c(2,.6,0), mar=c(3,3,3,1))
plot(x, y, type="l", xlab="", ylab="", col="blue")
grid(col="grey60")
points(2, 2^2, bg="white", col="blue", pch=21)
dev.off()
