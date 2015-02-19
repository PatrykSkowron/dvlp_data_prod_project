library(Quandl)

Quandl.search(query = "NY.GDP.MKTP.CD", page=1)

mydata = Quandl("FRED/NY.GDP.MKTP.CD") #, start_date="yyyy-mm-dd", end_date="yyyy-mm-dd")

Quandl.auth("44wJkwcjJQbsKDE6FaQ1")

IMF/MAP_WEO_NGDPPC

NY.GDP.MKTP.CD
NY.GDP.MKTP.KD
system.time(data<-WDI(indicator='NY.GDP.MKTP.KD',  start=2012, end=2014)) #country=c('MX','CA','US'),
#u¿ytkownik     system   up³ynê³o 
#1.12       0.26       1.65

system.time(data2<-WDI(indicator='NY.GDP.MKTP.KD',  start=1900, end=2014))
#u¿ytkownik     system   up³ynê³o 
#21.23       4.43      28.81 

system.time(dat3<-data2[data2$year %in% seq(1900,2014) & data2$country=="Poland",])

data<-WDI(indicator='NY.GDP.MKTP.KD',  start=1980, end=2014)

dataf<-data[data$country=="Germany" & data$year %in% seq(1990,2010),c("year","NY.GDP.MKTP.KD")]
#format(input$dates[2], "%Y"))),c("year","NY.GDP.MKTP.KD"
plot(gvisLineChart(data,xvar="year",yvar="NY.GDP.MKTP.KD"))

plot(gvisLineChart(dataf,xvar="year",yvar="NY.GDP.MKTP.KD",options=list(title=paste(x),hAxis="{title:'Year'}")))

#,vAxis="{title:'GDP in millions US $ (2000y)'}"
