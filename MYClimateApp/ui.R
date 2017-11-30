
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#


shinyUI(fluidPage(
  img(src="36_Earth-Now-v2.png", align = "right",height='200px',width='400px'),
  
  # Application title
  titlePanel("Climate Data Application(RCP's)"),
  helpText("Note: The app compares the observed datasets",
           "with the future projections of the same parameter,",
           "based on different RCP scenarios"),

  # Sidebar with user input controls
  sidebarLayout( 
    sidebarPanel(
      selectInput(inputId='site', 
                  label="Choose SNOTEL Site", 
                  choices=unique(snoteldata$Station), 
                  selected = NULL, 
                  multiple = FALSE,
                  selectize = TRUE, 
                  width = NULL, 
                  size = NULL),
      radioButtons(inputId='rcp',
                   label="Choose RCP:",
                   choices=c('RCP2_6','RCP4_5','RCP6_0','RCP8_5'),
                   inline=TRUE,
                   selected=NULL),
      radioButtons(inputId='parameters',
                   label="Choose Parameter:",
                   choices=c('Precipitation','Tmax_proj','Tmin_proj'),
                   inline=TRUE,
                   selected=NULL),
      
        
        # make a date range selector
        dateRangeInput("dates", label = h3("Date range"),start="2005-01-02",end="2057-01-01" ),
        
       
        checkboxInput("checkbox",label = h3("Display Observed Data"), value=FALSE)
    ),

    # Show outputs, text, etc. in the main panel
    mainPanel(
    
      textOutput("selected_rcp"),
      plotOutput("futureplot"),
      textOutput("summaryresults")
      
    )
  )
))
