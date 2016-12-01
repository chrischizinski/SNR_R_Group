feffect <- function(lm,fact,error) {
  b <- anova(lm)
  c <- data.frame(b)
  m <- c[fact,"Mean.Sq"]
  names(m) <- c("MS")
  m1 <- c[error,"Mean.Sq"]
  m2 <- m/m1
  names(m2) <- c("MS")
  p <- 1-pf(m2,c[fact,"Df"],c[error,"Df"])
  names(p) <- c("p")
  n <-cbind(MS=m2, Pvalue=p)
  row.names(n) <- fact
  n
}
