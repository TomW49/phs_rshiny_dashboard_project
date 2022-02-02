

library(shiny)

# Define UI for application that draws a histogram
ui <- dashboardPage(
  dashboardHeader(title = "Basic dashboard"),
  dashboardSidebar(disable = TRUE),
  dashboardBody(
    
    fluidRow(
      infoBox("Title", 
              value = icon("angle-up"), 
              "7%", 
              width = 3,
              icon = icon("ambulance")),
      
      infoBox("Demographic most effected by winter", 
              value = icon("angle-up"), 
              "70-79", 
              width = 3,
              icon = icon("male")),
      column(6),
      img(src = "phs-logo.png", height = 100, width = 250)
    ),
    
    fluidRow(
      column(8,
             fluidRow(
               box(plotOutput(outputId = "simd_quarter", height = 280),
                   width = 8, height = 300),
               box(plotOutput(outputId = "sex_plot", height = 280), 
                   width = 4, height = 300)
             ),
             fluidRow(
               box(plotlyOutput(outputId = "capacity_plot", height = 280),
                   width = 7, height = 300),
               box(plotOutput(outputId = "age_plot", height = 280), 
                   width = 5, height = 300)
             )
      ),
      column(4,
             box(leafletOutput(outputId = "admissions_ae", height = 600),
                 width = NULL, height = 620)
      )
    ),
    
    fluidRow(
      tabBox(title = "Media Quotes",
             tabPanel("The Sun", "Quotesudhfusdhfukshfkhsfk
                      sufghhsdfuhsfuhsufhsuhfshf
                      fsiudfidjfisefuoisf
                      sfiojsifjsdfjf"),
             tabPanel("The Observer", "Quote")),
      box(title = "Glossary",
          collapsible = TRUE,
          "blah blah blah"
      )
    )
  )
)



# Define server logic required to draw a histogram
server <- function(input, output) {

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
