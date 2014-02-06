### some 101 level info when dealing with datetime variables
start_date <- c("1973-01-01")
start_time <- c("00:00:00")

x <- paste( start_date, start_time )
start_dtime <- strptime( x, "%Y-%m-%d  %H:%M:%S" )

.Internal( inspect( start_dtime ) )

months( start_dtime )
weekdays( start_dtime )

#########################################

## n is the # of hours in a 365-day year
n <- 24*365

## some simple initilization
y <- rnorm( n)
id <- seq( 1 : n )
year <- rep( 1, n )
month <- rep( 1, n )
day <- rep( 1, n )
hour <- rep( 1, n )

mydata <- data.frame( int_id = id, dbl_y = y, int_year = year, int_month = month, int_day = day, int_hour = hour  )

## if you want to make it slow, please try to see how things go if using loops for the vectorized code below
this_time <- as.POSIXlt( start_dtime + 3600 * ( id - 1 ) )

bb <- unclass( this_time )

mydata$int_year <- bb$year

##mon is 0 based so +1 to make it right
mydata$int_month <- bb$mon + 1

mydata$int_day <- bb$mday
mydata$int_hour <- bb$hour

##0 = Sunday, 1 = Monday,...
mydata$int_wkday <- bb$wday

write.csv( mydata, "mydata.csv" )

#########################################

