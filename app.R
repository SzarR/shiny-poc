
library(shiny)
library(dplyr)
library(readr)
library(shinythemes)
library(shinyWidgets)
library(shinydashboard)
library(shinyalert)

ui <- # Define UI for application that draws a histogram
  shinyUI(fluidPage(

    useShinyalert(),

    theme = shinytheme("darkly"),

    # Application title
    titlePanel("Database Query Proof of Concept"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
      sidebarPanel(
        textInput(inputId = "id_var",
                  label = "Please enter the Candidate ID."
                  ),
        actionButton("do", "Go!")
      ),

      # Show a plot of the generated distribution
      mainPanel(
        #textOutput("Test")
      )
    )
  ))

# Define server logic required to draw a histogram
server <- function(input, output) {

  dataframe <- readr::read_csv(file = './data/Sample Data Set.csv')

  observeEvent(input$do, {




  #output$value <- "test"

    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white')
    })
}

# Run the application
shinyApp(ui = ui, server = server)
