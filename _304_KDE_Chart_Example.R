### using kde
library( MASS )

myData <- read.csv( "C:\\Users\\dongzn\\Desktop\\_01_27_short_talk\\_2014_sample_code\\hourly_example_K2080.csv" )

pdf( "C:\\Users\\dongzn\\Desktop\\_01_27_short_talk\\_2014_sample_code\\kde.pdf" )

plot( myData$dbl_temp, myData$dbl_load, col = "blue", xlab = "hourly temperature (F)", ylab = "hourly load (kwh)", main = "hourly temperature (F) and load (kwh)" )

f1 <- kde2d( myData$dbl_temp, myData$dbl_load )

filled.contour( f1, color = terrain.colors, plot.title = title( main = paste( "hourly temperature and load",sep = "" ), xlab = "hourly temperature", ylab = "hourly load", sub = "kernel density estimate" ) )

dev.off()
