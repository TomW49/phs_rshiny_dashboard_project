ui <- dashboardPage(
  dashboardHeader(title = "Basic dashboard"),
  dashboardSidebar(disable = TRUE),
  dashboardBody(
    
    fluidRow(
      column(8,
             fluidRow(
               box(plotOutput(outputId = "simd_quarter", height = 280),
                   width = 8, height = 300),
               box(plotOutput(outputId = "sex_plot", height = 280), 
                   width = 4, height = 300)
             ),
             fluidRow(
               box(plotOutput(outputId = "capacity_plot", height = 280),
                   width = 7, height = 300),
               box(plotOutput(outputId = "age_plot", height = 280), 
                   width = 5, height = 300)
             )
      ),
      column(4,
             box(leafletOutput(outputId = "admissions_ae", height = 600),
                 width = NULL, height = 620)
      )
    )
  )
)

