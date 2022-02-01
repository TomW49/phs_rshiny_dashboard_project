ui <- fluidPage(
  
  # Application title
  titlePanel(""),
  
  #tags$h1 makes header
  titlePanel(tags$h1("Winter's effect on the NHS")),
  
  fluidRow(
    column(4
           
    ),
    column(4
           
    ),
    column(4
           
    )
  ),
  
  fluidRow(
    column(5,
           plotOutput(outputId = "capacity_plot", height = 250),
           plotOutput(outputId = "simd_quarter", height = 250)
    ),
    column(3,
           
    ),
    column(4,
           leafletOutput(outputId = "admissions_ae", height = 500)
    )
  )
)
