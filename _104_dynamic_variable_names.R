
##
mymdat <- matrix( rnorm(800), nrow = 20, ncol = 40 )
mydata <- as.data.frame( mymdat )

## now you have 20 rows, 40 cols in your data set
## here is a subset of the 40 cols

var_list <- c( "V10", "V20", "V23", "V13", "V4", "V8", "V12" )

windows(record=TRUE)
## how to histograms for all of the variables in the list?
for ( i in 1 : length( var_list ) )
{
	this_var <- paste( "mydata$", var_list[ i ], sep = "" )
	## mean
	print( mean( eval( parse( text = this_var ) ) ) )
	## histograms of each selected variable
	hist( eval( parse( text  = this_var ) ), main = paste( this_var,  sep = ""), xlab = "value bins" )
}
windows(record=FALSE)

## as.formula example
str_model_spec <- "V15 ~ -1 "

for ( i in 1 : length( var_list ) )
{
	str_model_spec <- paste( str_model_spec, " + ", var_list[ i ], sep = "" )
}

mylm <- lm( as.formula( str_model_spec ), data = mydata )


