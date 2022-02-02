ui <- dashboardPage(
  dashboardHeader(title = "NHS Scotland - \"The Winter Crisis\"",
                  titleWidth = 350),
  dashboardSidebar(disable = TRUE),
  dashboardBody(
    
    fluidRow(
      column(8,
             box(title = "About", width = NULL)
      ),
      column(4,
             box(img(src = "phs-logo.png", 
                     height = "100%", 
                     width = "100%"), 
                 width = NULL)
      )
    ),
    
    fluidRow(
      # for info-boxes
      infoBox("A%E Admissions increase from 2019 to 2020 winter", 
              value = icon("angle-up"), 
              "7%", 
              width = 3,
              icon = icon("ambulance")),
      
      infoBox("Demograpic count most effected by winter", 
              value = icon("angle-up"), 
              "70-79", 
              width = 3,
              icon = icon("male")),
      
      infoBox("Deprivation level most effected by winter", 
              value = icon("angle-up"), 
              "Level 3 (Medium deprivation)", 
              width = 3,
              icon = icon("house-user")),
      
      infoBox("Male vs Female average length of stay", 
              value = icon("angle-up"), 
              "Females stay longer", 
              width = 3,
              icon = icon("venus")),
    ),
    
    selectInput("admission_input",
                "Which Admission Type?",
                choices = c("Elective Inpatients",
                            "Emergency Inpatients",
                            "Transfers",
                            "All Day cases",
                            "All Inpatients",
                            "All Inpatients and Day cases",
                            "Not Specified")
    )
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

