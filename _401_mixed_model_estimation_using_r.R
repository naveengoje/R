library( MASS )

## load the data
mydata <- read.csv( "C:\\Users\\dongzn\\Desktop\\_01_27_short_talk\\_2014_sample_code\\rcb_data_for_mixed_model.csv" )

param_vec <- rep(2, 5)

param_vec

param_vec <- rep(2, 5)

fr <- function( param_vec ) {

	y = as.matrix( mydata[, 1] )

	x = as.matrix( mydata[, 3:5] )
	
	z = as.matrix( mydata[, 6:12] )

	G = param_vec[4] * diag( 7 )

	R = param_vec[5] * diag( 21 )

	V = z %*% G %*% t(z) + R

	beta <- param_vec[1:3]

	r = y - x %*% beta

	log( abs( det(V) ) ) + t(r) %*% ginv( V ) %*% r + 21 * log( 2 * 3.1415926 ) 

}

param_vec[1] = 69

param_vec[2] = 69

param_vec[3] = 69

param_vec[4] = 9

param_vec[5] = 9

optim( param_vec, fr)

/***
sas results :



                                        The Mixed Procedure

                                         Model Information

                       Data Set                     WORK.RCB
                       Dependent Variable           pres
                       Covariance Structure         Variance Components
                       Estimation Method            ML
                       Residual Variance Method     Profile
                       Fixed Effects SE Method      Model-Based
                       Degrees of Freedom Method    Containment


                                      Class Level Information

                         Class    Levels    Values

                         ingot         7    1 2 3 4 5 6 7
                         metal         3    c i n


                                            Dimensions

                                Covariance Parameters             2
                                Columns in X                      3
                                Columns in Z                      7
                                Subjects                          1
                                Max Obs Per Subject              21


                                      Number of Observations

                            Number of Observations Read              21
                            Number of Observations Used              21
                            Number of Observations Not Used           0


                                         Iteration History

                    Iteration    Evaluations        -2 Log Like       Criterion

                            0              1       121.09700964
                            1              1       115.70738589      0.00000000


                                     Convergence criteria met.

                                        The Mixed Procedure

                                       Covariance Parameter
                                             Estimates

                                       Cov Parm     Estimate

                                       ingot          9.8124
                                       Residual       8.8899


                                          Fit Statistics

                               -2 Log Likelihood               115.7
                               AIC (smaller is better)         125.7
                               AICC (smaller is better)        129.7
                               BIC (smaller is better)         125.4


                                     Solution for Fixed Effects

                                              Standard
               Effect    metal    Estimate       Error      DF    t Value    Pr > |t|

               metal     c         70.1857      1.6346      12      42.94      <.0001
               metal     i         75.9000      1.6346      12      46.43      <.0001
               metal     n         71.1000      1.6346      12      43.50      <.0001


                                    
***/
