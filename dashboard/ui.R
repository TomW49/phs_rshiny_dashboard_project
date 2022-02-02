ui <- dashboardPage(
  dashboardHeader(title = "NHS Scotland - \"The Winter Crisis\"",
                  titleWidth = 350),
  dashboardSidebar(disable = TRUE),
  dashboardBody(
    
    fluidRow(
      column(9
             # space for "about" box
      ),
      img(src = "phs-logo.png", height = 100, width = 250)
    ),
    
    fluidRow(
      # for info-boxes
      infoBox("Title", 
              value = icon("angle-up"), 
              "7%", 
              width = 3,
              icon = icon("ambulance"))
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

