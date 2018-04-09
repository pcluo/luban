library(feather)
library(lfe)
library(lubridate)
library(plyr)
library(tidyverse)
library(stargazer)
library(haven)


'%!in%' <- function(x,y)!('%in%'(x,y))

winsor1 = function (x, fraction=c(0.05,.05))
{
   if(length(fraction) != 2 || fraction[1] < 0 || fraction[2] < 0 || fraction[1] > 0.5|| fraction[2] > 0.5) {
      stop("bad value for 'fraction'")
   }
   lim <- quantile(x, probs=c(fraction[1], 1-fraction[2]), na.rm=T)
   x[ x < lim[1] ] <- lim[1]
   x[ x > lim[2] ] <- lim[2]
   x
}

winsor2 = function (x, multiple=3)
{
  if(length(multiple) != 1 || multiple <= 0) {
    stop("bad value for 'multiple'")
  }
  med <- median(x)
  y <- x - med
  sc <- mad(y, center=0, na.rm = T) * multiple
  y[ y > sc ] <- sc
  y[ y < -sc ] <- -sc
  y + med
}

# lag time series by time, instead of index
tlag <- function(x, n = 1L, time) {
  index <- match(time - n, time, incomparables = NA)
  x[index]
}

# caputre string output of function x
get.stdout = function(x) paste(capture.output(x), collapse="", sep="")

calc_robust_se = function(output) sqrt(diag(sandwich::vcovHC(output, type = "HC1")))
calc_nw_se = function(output) sqrt(diag(sandwich::NeweyWest(output, type = "HC1")))

library(Rcpp)
cppFunction('NumericVector rcpp_clip( NumericVector x, double a, double b){
    return clamp( a, x, b ) ;
}')


stars.pval <- function(p.value)
    {
        unclass(
            symnum(p.value, corr = FALSE, na = FALSE,
                   cutpoints = c(0, 0.01, 0.05, 0.1, 1),
                   symbols = c("***", "**", "*", " "))
            )
    }
# ==================================================================================================
# useful scripts
# count non missing by column
# colSums(!is.na(df %>% select(starts_with('pct_f_widowed'))))

# missing_values <- properties %>% summarize_each(funs(sum(is.na(.))/n()))
#
# missing_values <- gather(missing_values, key="feature", value="missing_pct")
# missing_values %>%
#   ggplot(aes(x=reorder(feature,-missing_pct),y=missing_pct)) +
#   geom_bar(stat="identity",fill="red")+
#   coord_flip()+theme_bw()