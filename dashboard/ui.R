ui <- fluidPage(
  
  # Application title
  titlePanel(""),
  
  #tags$h1 makes header
  titlePanel(tags$h1("Winter's effect on the NHS")),
  
  theme = shinytheme("paper"),
  
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
           plotOutput(outputId = "capacity_plot", height = 300),
           plotOutput(outputId = "simd_quarter", height = 300)
    ),
    column(3,
           plotOutput(outputId = "sex_plot", height = 300),
           plotOutput(outputId = "age_plot", height = 300)
    ),
    column(4,
           leafletOutput(outputId = "admissions_ae", height = 600)
    )
  )
)
