ui <- fluidPage(
  
  # Application title
  titlePanel(""),  theme = shinytheme("cyborg"),
  
  #tags$h1 makes header
  titlePanel(tags$h1("Winter's effect on the NHS")),

  fluidRow(
    column(
      
    ),
    column(
      
    ),
    column(
      
    )
  ),
  
  fluidRow(
    column(
      fluidRow(
        
      ),
      fluidRow(
        
      )
    ),
    column(
      fluidRow(
        
      ),
      fluidRow(
        plotOutput(outputId = "capacity_plot")
      )
    ),
    column(
      
    )
  )
)