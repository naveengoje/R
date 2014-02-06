## another small example on vectorization
######################################################

n <- 100
x <- rnorm( n )
y <- sapply( x, function(x) max( 0, 1 - exp( x )  ) )

######################################################

int_nGroup <- 10000
int_nEach <- 10

int_nrow <- int_nGroup * int_nEach
int_ncol <- 3

xm <- matrix( rnorm( int_nrow * int_ncol ), nrow = int_nrow, ncol = int_ncol )

grp_id <- rep( 1 : int_nGroup, each = int_nEach )

xdata <- cbind( grp_id, xm )

xdataframe <- as.data.frame( xdata )

######################################################

start_time <- Sys.time()
myReg <- function(x)
{
	lm( V2 ~ V3 + V4, data = x )
}
by( xdataframe, grp_id  , myReg )
end_time <- Sys.time()

start_time;end_time
print( time_elapsed <- end_time - start_time )

#######################################################

######################################################

start_time <- Sys.time()
for ( i in 1 : int_nGroup )
{
	newdata <- subset( xdataframe, grp_id == i )

	mylm <- lm( V2 ~ V3 + V4, data = newdata )
}
end_time <- Sys.time()

start_time;end_time
print( time_elapsed <- end_time - start_time )
######################################################

## conclusion : vectorized version is way faster than the loop version