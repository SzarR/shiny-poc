
library(shiny)
library(dplyr)
library(readr)
library(shinythemes)
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
        verbatimTextOutput('id_demo_status')
      )
    )
  ))

# Define server logic required to draw a histogram
server <- function(input, output) {

  # Read external data file.
  dataframe <- readr::read_csv(file = './data/Sample Data Set.csv')

  observeEvent(input$do, {

    checker <-
      dataframe %>%
      filter(input$id_var %in% Person_ID) %>%
      nrow()

    if (checker == 0) {
      shinyalert(type = 'error', text = 'The ID was not found in the database.')
    }

  })

output$id_demo_status <- renderText({

  req(input$do)

  dataframe %>%
    filter(Person_ID == input$id_var) %>%
    mutate(Diverse = ifelse(Diverse == FALSE, "NOT DIVERSE", "DIVERSE")) %>%
    pull(Diverse)

})
}

# Run the application
shinyApp(ui = ui, server = server)
