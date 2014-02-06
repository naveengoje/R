
## setup a column vector data in excel and then copy it to system clipboard
## this will not work for row vector, or other things.
aa <- as.numeric(  readClipboard() )

aa <- 100 * aa

## write it to system clipboard
writeClipboard( as.character( aa ) )

######## or you can use aa <- scan() function
### copy the excel column over into the Console, then press enter to complete
bb <- scan()

##################################################

###.Internal( inspect( ) ), which tells "REALSXP" structure info
.Internal( inspect( aa ) )



