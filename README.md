# Gross Domestic Product (GDP) visualization
## Developing data products project documentation
### Author: Patryk Skowron

My shiny application main purpose is to show GDP of choosen country / region data in years specified by user. Firstly application retreives data from World Bank server using "WDI" package:


```r
dataInput<-reactive({WDI(indicator='NY.GDP.MKTP.KD',  start=1960, end=2014)
```

It is quite time consuming so application download data only once (data is updated not so often, perhaps once a year) and stores data in dataInput.

Secondly, application takes user imput to choose data relevant for specified country and date range. 


```r
 countryInput<-reactive({
    dat<-dataInput()[dataInput()$country==input$select.country & dataInput()$year %in% seq(as.numeric(format(input$dates[1], "%Y")),as.numeric(format(input$dates[2], "%Y"))),]
    dat<-dat[order(dat$year),]
    colnames(dat)[3]<-"GDP"
    as.data.frame(dat)
  })
```

Then the Global.GDP is computed. Global GDP is a sum of all GDP year by year.

In the and, the interactive plot is printed, thanks to googleVis package


```r
output$plot <- renderGvis({
  if(input$radio.type==1) {
    ifelse(input$ch.logy==TRUE,g<-gvisLineChart(finalInput(),xvar="year",yvar="GDP",options=list(title=paste(input$select.country),vAxis="{title:'GDP in US $,log scale',format:'###### $',logScale:'true'}",hAxis="{title:'Year'}"))
           ,g<-gvisLineChart(finalInput(),xvar="year",yvar="GDP",options=list(title=paste(input$select.country),vAxis="{title:'GDP in US $',format:'###### $',logScale:'false'}",hAxis="{title:'Year'}")))
  }
  if(input$radio.type==2) g<-gvisLineChart(finalInput(),xvar="year",yvar="Global.GDP",options=list(title=paste(input$select.country),vAxis="{title:'Share of global GDP (%)',format:'#.###%'}",hAxis="{title:'Year'}"))
  return(g)
})
```

This is only first simplified version of application. There may be added additional features in future like interactive world map showing GDP of highlighted country etc.

