#dataInput<-WDI(indicator='NY.GDP.MKTP.KD',  start=2000, end=2014)

shinyUI(fluidPage(
  titlePanel("Gross Domestic Product (GDP) by country in constant US $ (2000)"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Wait about 20 seconds to load data from World Bank servers..."),
      uiOutput("select.choices"),
      #selectInput("select.country",label=h3("Choose country / region to display"),choices=list(dataTableOutput("listc"))),
      dateRangeInput("dates",label=h3("Choose date range to show"),start=1960,end=2014,format="yyyy",startview="decade"),
      radioButtons("radio.type",label=h3("Plot type"),choices=list("GDP in US $"=1,"Percentage of Global GDP"=2),selected=1),
      checkboxInput("ch.logy",label="Y axis in log scale")
    ),
    mainPanel(htmlOutput("plot")
      
              )
    
    )
    
  
))