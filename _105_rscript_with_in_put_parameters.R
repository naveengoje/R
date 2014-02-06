## this is useful when your R code takes user input to direct the path of flow/execution...
## you can batch process things in this way using command-line batch file...
print( "hello world!")

args <- commandArgs( TRUE )

print( length( args ) )

for ( i in 1 : length( args ) )
{
	print( args[ i ] )
}

## if you know #2 is number, then you can do
##print( as.numeric( args[ 2 ] ) )
