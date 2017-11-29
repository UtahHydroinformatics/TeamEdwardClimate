
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#


shinyUI(fluidPage(
  # Copy the line below to make a date range selector
  dateRangeInput("dates", label = "Date Range for Projected Data", 
                 start = "2005-01-02", end = "2057-01-02"),

  # Application title
  titlePanel("Climate Data Application"),

  # Sidebar with user input controls
  sidebarLayout( 
    sidebarPanel(selectInput(inputId = "site",
                             label = "Choose SNOTEL Site",
                             choices = unique(snoteldata$Station),
                             selected = NULL,
                             multiple =FALSE,
                             selectize = TRUE,
                             width = NULL,
                             size = NULL),
    radioButtons(inputId = 'rcp',
                label = "Choose RCP:",
                choices = c('RCP2_6', 'RCP4_5', 'RCP6_0', 'RCP8_5'),
                inline = TRUE,
                selected = NULL),
    dateRangeInput("dates", label = h3("Date Range"), start = "2005-01-02", end = "2057-01-01"),
    checkboxInput("checkbox", label = h3("Display Observed Data"), value = FALSE)
     
    ),

    # Show outputs, text, etc. in the main panel
    mainPanel( 
      textOutput("selected_rcp"),
      plotOutput("futureplot"),
      textOutput("summaryresults"),
      leafletOutput("snotelmap")
      
    )
  )
))

