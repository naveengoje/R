	old_par <- par()

	this_data <- read.csv( "C:\\Users\\dongzn\\Desktop\\_01_27_short_talk\\_2014_sample_code\\hourly_example_K2080.csv" )

	this_data$yearmonth <- this_data$year * 100 + this_data$month

	x_mark <- subset( this_data, day == 1 & hour == 0 )

	x_pos <- as.numeric( rownames( x_mark ) )

	pdf( "C:\\Users\\dongzn\\Desktop\\_01_27_short_talk\\_2014_sample_code\\overlay_hourly_8784.pdf")

	layout(rbind(1,2), heights=c(7,1))
	layout.show( n = 2 )
	
	par( mar = c(3,6,3,6) )
	
	plot( this_data$dbl_load, yaxt = 'n', xaxt = 'n', type = 'l', main = paste( "hourly_example_K2080.csv", sep = ""), col = "blue", xlab = "", ylab = "" )

	##draw monthly boundaries
	abline( v = x_pos, col = "green" )

	##draw left axis
	axis( side = 2 )
	mtext( "dbl_load", side = 2, line = 3 )

	##draw bottom axis
	axis( side = 1, at = x_pos, labels = paste( x_mark$yearmonth, sep = "" ), las = 1 )
	mtext( "year month", side = 1, line = 3 )

	par( new = TRUE )

	plot( this_data$dbl_temp, type = 'l', col = "red", xaxt = 'n', yaxt = 'n', xlab = "", ylab = "" )

	##draw right axis
	axis( side = 4 )
	mtext( "dbl_temperature", side = 4, line = 3 )
	

###################

	par( mar = c(0,0,0,0 ) )
	plot.new()
	legend( 'center', 'groups', c("load", "temperature" ), col = c('blue', 'red' ), lty = 1, ncol = 2, bty = "n" )
	
	##dev.off()
###################

	par( old_par )
	
	dev.off()
	
################### some nice URLs on this topic #################
## margins
##http://rgraphics.limnology.wisc.edu/images/layouts/rmargins_sf.png

## more examples 
##http://research.stowers-institute.org/efg/R/Graphics/Basics/mar-oma/index.htm?utm_source=twitterfeed&utm_medium=twitter	
	
## R graph
##https://www.stat.auckland.ac.nz/~paul/Talks/Rgraphics.pdf


