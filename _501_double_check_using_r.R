## the data below is a full column rank case, for cases less than full rank, the c++ sample code does not apply.
mydata <- read.csv( "C:\\Users\\dongzn\\Documents\\zd_visual_studio_projects\\lin_reg_using_rlapack\\lin_reg_using_rlapack\\aa.csv" )

mydata

mylm <- lm( y ~ x1 + x2 + x3 + x4 + x5, data = mydata )

summary( mylm )





