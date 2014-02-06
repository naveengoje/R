
library( RODBC )

odbcDataSources()

##library( sqldf )

channel <- odbcDriverConnect( "Driver = SQL Server; Server = DONGZNTHINKPAD\\MSSQLSERVER2008; Database = Company_A; Trusted_Connection = yes" )

mydbo <- sqlTables( channel )
subset( mydbo, TABLE_SCHEM == "dbo" )


## take a look at the data from the 100_houses_kwh_usage

str_sql_command <- paste( "SELECT TOP 20 * FROM [Company_A].[dbo].[100_houses_kwh_usage]", sep = "" )

mydata <- sqlQuery( channel, str_sql_command )

## what are the data types of each column
sapply( mydata, class)

str_sql_command <- paste( "SELECT DISTINCT [str_service_point_id] FROM [Company_A].[dbo].[100_houses_kwh_usage]", sep = "" )

all_ids <- sqlQuery( channel, str_sql_command )

nrow( all_ids )

## take a look at the 10th id in the all_id list
str_sql_command <- paste( "SELECT * FROM  [Company_A].[dbo].[100_houses_kwh_usage] WHERE [str_service_point_id] = ", all_ids$str_service_point_id[10], sep = "" )
the_10th_id_data <- sqlQuery( channel, str_sql_command )

## you can also do other type of sql commands: update, delete, insert, etc.

ls( mydata )

str( mydata )

odbcClose( channel )


