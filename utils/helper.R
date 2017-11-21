library(feather)
library(lfe)
library(lubridate)
library(plyr)
library(tidyverse)
library(stargazer)
library(haven)
library(stringr)

'%!in%' <- function(x,y)!('%in%'(x,y))

winsor1 = function (x, fraction=.05)
{
   if(length(fraction) != 1 || fraction < 0 ||
         fraction > 0.5) {
      stop("bad value for 'fraction'")
   }
   lim <- quantile(x, probs=c(fraction, 1-fraction), na.rm=T)
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


tlag <- function(x, n = 1L, time) {
  index <- match(time - n, time, incomparables = NA)
  x[index]
}

# library(sandwich)
# library(lmtest)
calc_robust_se = function(output) sqrt(diag(sandwich::vcovHC(output, type = "HC1")))

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