
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#



shinyServer(function(input, output) {
  
  output$selected_rcp <- renderText({ 
    paste('Viewing climate data at',input$site,'between',
          input$dates[1],'and',input$dates[2],'for',input$rcp)
  })
  
  output$futureplot <- renderPlot({
    plotdata <- subset(prcp_proj,Station==input$site &
                         Date >= input$dates[1] &
                         Date<= input$dates[2])
    
    
    # If you want to show an image coming from the web, first download it with R:
    #Download Edwards Beautiful Face
    download.file("https://cdn.images.express.co.uk/img/dynamic/36/590x/Twilight-star-Robert-Pattinson-as-Edward-Cullen-794437.jpg" , destfile="Edward.jpg")
    #Download All Three Beautiful Faces
    download.file("http://stuffpoint.com/twilight/image/291711-twilight-edward-bella-jacob.jpg" , destfile="Jacob.jpg")
    #Downlaod Bella's Beautiful Face
    download.file("http://s3.foreveryoungadult.com.s3.amazonaws.com/_uploads/images/36191/bellaswan_header__span.jpg" , destfile="Bella.jpg")
    Picture=readJPEG(paste(input$pic, ".jpg", sep = ""))
    
    if(input$checkbox==TRUE){
      plot(x=plotdata$Date,y=plotdata[,input$rcp],type='n', main="", xlab="Date", ylab="Precip") 
      rasterImage(Picture, par()$usr[1], par()$usr[3], par()$usr[2], par()$usr[4])
      grid()
      lines(plotdata$Date, plotdata[,input$rcp], type="l", lwd=1, col="white")
      lines(x=snoteldata$Date,y=snoteldata$DailyPrecip, col="purple")
      
    }else{
      plot(x=plotdata$Date,y=plotdata[,input$rcp],type='n', main="", xlab="Date", ylab="Precip") 
      rasterImage(Picture, par()$usr[1], par()$usr[3], par()$usr[2], par()$usr[4])
      grid()
      lines(plotdata$Date, plotdata[,input$rcp], type="l", lwd=1, col="white")
      
    }
   
  })
  
  futureavg <- reactive({
    futuredata <- subset(prcp_proj, Station==input$site &
                         Date >= input$dates[1] &
                         Date <= input$dates[2])
    futuremean <- mean(futuredata[,input$rcp])
    return(futuremean)
  })
  observedavg <- reactive({
    observeddata <- subset(snoteldata, Station==input$site)
    observedmean <- mean(observeddata[,"DailyPrecip"], na.rm=TRUE)
    return(observedmean)
  })
  
  output$snotelmap <- renderLeaflet({
    # Use leaflet() here, and only include aspects of the map that
    # won't need to change dynamically (at least, not unless the
    # entire map is being torn down and recreated).
    leaflet(data = locations) %>% 
      addTiles() %>%
      addMarkers(~long, ~lat, label=~as.character(Station),
                 icon = twilighticon)
  })
  
  output$summaryresults <- renderText({
    paste("Average Observed Precipitation", observedavg(), "Average Future Precipitation", futureavg())
  })
})
