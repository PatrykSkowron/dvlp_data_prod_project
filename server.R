require(shiny)
require(quantmod)
require(googleVis)
require(ggplot2)
require(knitr)
require(WDI)
# server.R

shinyServer(function(input, output) {
  dataInput<-reactive({WDI(indicator='NY.GDP.MKTP.KD',  start=1960, end=2014)
})
  
output$select.choices<-renderUI({
  selectInput("select.country",label=h3("Choose country / region to display"),choices=as.list(unique(dataInput()$country)))
})
    


  countryInput<-reactive({
    dat<-dataInput()[dataInput()$country==input$select.country & dataInput()$year %in% seq(as.numeric(format(input$dates[1], "%Y")),as.numeric(format(input$dates[2], "%Y"))),]
    dat<-dat[order(dat$year),]
    colnames(dat)[3]<-"GDP"
    as.data.frame(dat)
  })


globalGDP<-reactive({
  years<-unique(countryInput()$year)
  dat<-dataInput()[dataInput()$year %in% years,]
  agg<-aggregate(NY.GDP.MKTP.KD ~ year,dat,sum)
  agg<-agg[order(agg$year,decreasing=F),]
  colnames(agg)[2]<-"Global.GDP"
  agg
})

finalInput<-reactive({
  dat<-cbind(countryInput(),countryInput()[,3]/globalGDP()$Global.GDP)
  colnames(dat)[ncol(dat)]<-"Global.GDP"
  dat
})

output$plot <- renderGvis({
  if(input$radio.type==1) {
    ifelse(input$ch.logy==TRUE,g<-gvisLineChart(finalInput(),xvar="year",yvar="GDP",options=list(title=paste(input$select.country),vAxis="{title:'GDP in US $,log scale',format:'###### $',logScale:'true'}",hAxis="{title:'Year'}"))
           ,g<-gvisLineChart(finalInput(),xvar="year",yvar="GDP",options=list(title=paste(input$select.country),vAxis="{title:'GDP in US $',format:'###### $',logScale:'false'}",hAxis="{title:'Year'}")))
  }
  if(input$radio.type==2) g<-gvisLineChart(finalInput(),xvar="year",yvar="Global.GDP",options=list(title=paste(input$select.country),vAxis="{title:'Share of global GDP (%)',format:'#.###%'}",hAxis="{title:'Year'}"))
  return(g)
})

})