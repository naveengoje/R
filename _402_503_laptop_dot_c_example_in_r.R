library( quantreg )


my_dll_path <- "C:\\Users\\dongzn\\Documents\\zd_visual_studio_projects\\r_call_c_using_dot_c\\Release\\r_call_c_using_dot_c.dll"

dyn.load( my_dll_path )

nCols <- 4
nRows <- 40

y <- rnorm( nRows )
x <- rnorm( nCols * nRows )
mx <- matrix( x, nrow = nRows, ncol = nCols )
mx[, 1] = 1.0

beta <- double( nCols )

## void my_mini_qr( int* int_nCols, int* int_nRows, double* dbl_vec_y, double* dbl_design_matrix_x, double* dbl_beta, double* dbl_tau);
my_tau <- 0.5

myres <- .C( "my_mini_qr", as.integer( nCols ), as.integer( nRows ), as.double( y ), as.double( mx ), as.double( beta ), as.double( my_tau ) )

################### check 

dmx <- as.data.frame( cbind( y, mx) )

myrq <- rq( y ~ V3 + V4 + V5, tau = my_tau, data = dmx )

summary( myrq )

## pay attention to the beta values, are they updated?
beta


dyn.unload( my_dll_path )
