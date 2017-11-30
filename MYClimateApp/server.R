
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#
library(ggplot2)

shinyServer(function(input, output) {

  output$selected_rcp<-renderText({paste('Viewing climate data at',input$site,'between',
                                         input$dates[1],'and',input$dates[2],'for',input$rcp)
    })
  
  output$futureplot<-renderPlot({plotdata <- subset(prcp_proj,Station==input$site &
                                                     Date >= input$dates[1] &
                                                     Date<= input$dates[2])
  if(input$checkbox==TRUE){
    ggplot()+  geom_line(data=plotdata,aes(x=plotdata$Date,y=plotdata[,input$rcp]),color='red')+xlab("Date") + ylab("Precip(inch)")+    geom_line(data=snoteldata,aes(x=Date,y=DailyPrecip),color='black')
  }else{
    ggplot()+ geom_line(data=plotdata,aes(x=plotdata$Date,y=plotdata[,input$rcp]))+xlab("Date") + ylab("Precip(inch)")    }
  
  })
  
  output$futureplot<-renderPlot({plotdata <- subset(tmax_proj,Station==input$site &
                                                      Date >= input$dates[1] &
                                                      Date<= input$dates[2])
  if(input$checkbox==TRUE){
    ggplot()+  geom_line(data=plotdata,aes(x=plotdata$Date,y=plotdata[,input$rcp]),color='red')+xlab("Date") + ylab("Temp(F)")+    geom_line(data=snoteldata,aes(x=Date,y=DailyPrecip),color='black')
  }else{
    ggplot()+ geom_line(data=plotdata,aes(x=plotdata$Date,y=plotdata[,input$rcp]))+xlab("Date") + ylab("Temp(F)")    }
  
  })
futureavg<- reactive({
  futuredata<-subset(prcp_proj,Station==input$site & 
                       Date>=input$dates[1]&
                       Date<=input$dates[2])
  futuremean<-mean(futuredata[,input$rcp])
  return(futuremean)
})
  observedavg<-reactive({
    observeddata<-subset(snoteldata,Station==input$site)
    observedmean<-mean(observeddata[,"DailyPrecip"],na.rm = TRUE)
    return(observedmean)
  })
  output$summaryresults<-renderText({
    paste("Average Observed Precipitation:",observedavg(),"Average Future Precipitation:",futureavg())
  })
})
