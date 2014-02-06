library( KernSmooth )
library( graphics )

## redu_pcts.csv
a <- read.csv( "C:\\Users\\dongzn\\Desktop\\_01_27_short_talk\\_2014_sample_code\\redu_pcts.csv" )

ls( a )

bclass <- unique( a$category )

pdf( "C:\\Users\\dongzn\\Desktop\\_01_27_short_talk\\_2014_sample_code\\redu_hist_var.pdf" )

for ( i in 1 : length( bclass ) )
{
	this_case <- NULL

	this_case <- subset( a, category == bclass[ i ] )

	x <- this_case$redu_pct_con

	est <- NULL

	est <- bkde( x )

	p_max <- max( est$y )

## sample percentiles
x_05 = quantile( x, 0.05 )
x_95 = quantile( x, 0.95 )

## min and max in the est grid
x_min <- min( est$x )
x_max <- max( est$x )

est_xy <- as.data.frame( est )

## subsetting the x values in <= x_05, >= x_95
x_below_05 <- subset( est_xy, x <= x_05 )
x_above_95 <- subset( est_xy, x >= x_95 )

## get the nearest approximate to x_05 and x_95 in the est grid, "_a" suffix stands for approximate
## this is later used to construct polygon corners
x_05_a <- max( x_below_05$x )
x_95_a <- min( x_above_95$x )

## create polygon (x,y) for the two regions
x_below_05 <- rbind( c(x_min, 0 ), x_below_05, c(x_05_a, 0 ) )
x_above_95 <- rbind( c(x_95_a, 0),x_above_95, c(x_max, 0 ) )

## histogram, freq = FALSE to have density estimate ( not necessarily in (0,1) ) on the y-axis. 
hist( x, xlim = c(x_min, x_max), ylim = c(0, p_max), col = rgb(1,0.5, 0.5, 1), freq = FALSE, xlab = paste( "peak reduction percentage, sample size = ", nrow( this_case),  sep = "" ),  ylab = "density estimate", main = paste( bclass[ i ], " peak reduction percentage", sep = "" ), sub = "shaded area has 0.05 probability under the density estimate curve" )

## kernel density estimate line, blue line, line style ( lty = 2 ) = dotted line, line width (lwd) = 2
lines( est$x, est$y, col = rgb(0,0,1,1), lty = 2, lwd = 2 )

abline( v = x_05_a, col = rgb(1, 0, 0, 1 ), lty = 1, lwd = 3 )

## lower 5% region under the kde curve, transparent green
polygon( x_below_05$x,  x_below_05$y, col=rgb(0, 1, 0, 0.5) )

## higher 5% region under the kde curve, transparent green
##polygon( x_above_95$x,  x_above_95$y, col=rgb(0, 1, 0, 0.5) )	

##################### adding arrows and annotation

arrow_x_start <- x_min

arrow_x_to <- x_05_a

arrow_y_start <- p_max * 0.90
arrow_y_to <- arrow_y_start

arrow_len <- 0.1

arrows( arrow_x_start, arrow_y_start, arrow_x_to, arrow_y_to, length = arrow_len, code = 2  )

str_var_value <- paste( "VaR = ",  round( x_05, 2), sep = "" )

dbl_width <- strwidth( str_var_value )

text_x_start <- x_05_a - dbl_width - 0.001

text_y_start <- p_max * 0.95

## pos = 4 : to the right of (x0,y0) start point, default offset is to offset half string width to make it centered at (x0, y0)
text( text_x_start, text_y_start, str_var_value, pos = 4, offset = 0  )

	 
}

dev.off()