library( sqldf )

//pick "15min_example_M3076_AKW"
my15min_data <- read.csv( file.choose() )

ls( my15min_data )

nrow( my15min_data )

## change col name
colnames( my15min_data )[ colnames( my15min_data ) == "dbl_temp" ] <- "dbl_temperature"

pdf( "C:\\Users\\dongzn\\Desktop\\_01_27_short_talk\\_2014_sample_code\\hourly.pdf" )

## 1st try, is the plot informative ? e.g. can you see monthly boundries?
plot( my15min_data$dbl_load, type = 'l', col = 'blue' )

## suppose that I want first to take max of each hour (i.e. among 4 15min values) to make the data hourly
str_sql <- paste( "select [year], [month], [day], [hour], max( [dbl_load] ) as [hourly_load] from [my15min_data] group by [year], [month], [day], [hour] order by [year], [month], [day], [hour]", sep = "" )

myhourly_data <- sqldf( str_sql )

myhourly_data[ 1 : 30, ]

plot( myhourly_data$hourly_load, type = 'l', col = 'blue' )

## adding monthly boundaries...
## need to get the row id
hour_id <- seq( 1 : nrow( myhourly_data ) )
myhourly_data <- cbind( myhourly_data, hour_id )

month_start_marks <- subset( myhourly_data, day == 1 & hour == 0 )

nrow( month_start_marks )

month_start_marks$yearmonth = month_start_marks$month + month_start_marks$year * 100

plot( myhourly_data$hourly_load, col = 'blue', xaxt = 'n', yaxt = 'n', xlab = "", ylab = "", type = 'l', main = paste( "hourly_example_M3076_AKW", sep = "") )

abline( v = rbind( month_start_marks$hour_id, nrow( myhourly_data ) ), col = 'green' , lty = 2, lwd = 2 )

## 4 sides : 1 : bottom, 2 : left, 3 : top, 4 : right
## you may want to change las = 1 to las = 2 to make the yearmonth lable from horizontal to vertical
axis( side = 1, at = month_start_marks$hour_id, labels = paste( month_start_marks$yearmonth, sep = "" ), las = 1 )

axis( side = 2 )

## lines = #, space in terms of # lines of text size, usually starting from 0, you may want to try other values...
mtext( "hourly_load (kwh)", side = 2, line = 3 )

mtext( "year month", side = 1, line = 4 )

##########################################################################

## mark summer months : 6, 7, 8, 9

ymin <- par( "usr" )[ 3 ]
ymax <- par( "usr" )[ 4 ]
for ( i in 6 : 9 )
{
	box_x <- rbind( month_start_marks$hour_id[ i ], month_start_marks$hour_id[ i ], month_start_marks$hour_id[ i + 1 ], month_start_marks$hour_id[ i + 1] )
	box_y <- rbind( ymin, ymax, ymax, ymin )

	polygon( box_x, box_y, col = rgb( 1, 1, 0, 0.5 ) )
}

## mark winter months : 12, 1, 2

for ( i in 1 : 2 )
{
	box_x <- rbind( month_start_marks$hour_id[ i ], month_start_marks$hour_id[ i ], month_start_marks$hour_id[ i + 1 ], month_start_marks$hour_id[ i + 1] )
	box_y <- rbind( ymin, ymax, ymax, ymin )

	polygon( box_x, box_y, col = rgb( 0, 1, 1, 0.5 ) )
}

for ( i in 12 : 12 )
{
	box_x <- rbind( month_start_marks$hour_id[ i ], month_start_marks$hour_id[ i ], nrow( myhourly_data ), nrow( myhourly_data ) )
	box_y <- rbind( ymin, ymax, ymax, ymin )

	polygon( box_x, box_y, col = rgb( 0, 1, 1, 0.5 ) )
}

dev.off()







