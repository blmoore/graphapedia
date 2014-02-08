svg("figs/uniform.svg", 3.5, 3)
par(mar=c(3,3,0.2,0.2), mgp=c(2,.35,0), lwd=2)
#set up plot area
plot(1:5, seq(0, 3, length.out=5), ylab="",
     type="n", axes=F, xlab="", frame=T)

#horizontal blue lines
segments(0,0,2,0, col="blue")
segments(4,0,6,0, col="blue")
segments(2,2,4,2, col="blue")
#axes
axis(1, lwd=1, tck=-.015, at=c(2,4), 
     labels=c("a", "b"), line=-0)
axis(2, tck=-.015, at=2, label=expression(frac(1,b-a)), las=1)

#vertical dashed lines
segments(2,0,2,2, lty=2, col="blue")
segments(4,0,4,2, lty=2, col="blue")

#points
points(matrix(c(2,0,4,0), ncol=2, byrow=T), 
       pch=21, bg="white", col="blue")
points(matrix(c(2,2,4,2), ncol=2, byrow=T), 
       pch=21, col="blue", bg="blue")

dev.off()
