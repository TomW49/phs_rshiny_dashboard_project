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
      infoBox("A%E Admissions 2019 + 2020", 
              value = icon("angle-up"), 
              "7%", 
              width = 3,
              icon = icon("ambulance")),
      
      infoBox("Demograpics effected", 
              value = icon("angle-up"), 
              "70-79", 
              width = 3,
              icon = icon("male")),
      
      infoBox("Deprivation level effected", 
              value = icon("angle-up"), 
              "Level 3 (Medium deprivation)", 
              width = 3,
              icon = icon("house-user")),
      
      infoBox("Average stay male vs female", 
              value = icon("angle-up"), 
              "Females stay longer", 
              width = 3,
              icon = icon("venus"))
    ),
    
    fluidRow(
      column(8,
             fluidRow(
               box(plotOutput(outputId = "simd_quarter", height = 250),
                   selectInput("admission_input",
                               label = "Select Admission Type",
                               choices = c("All", simd_quarter %>% 
                                             distinct(admission_type) %>% 
                                             pull()),
                               width = NULL),
                   width = 8, height = 325, style = "font-size:11px;"),
               box(plotOutput(outputId = "sex_plot", height = 250), 
                   width = 4, height = 325)
             ),
             fluidRow(
               box(
                 plotlyOutput(outputId = "capacity_plot", height = 250),
                 selectInput("specialty_input",
                         label = "Select Specialty",
                         choices = capacity_general %>% 
                           distinct(specialty_name) %>% 
                           pull(),
                         width = NULL),
                   width = 7, height = 325, style = "font-size:11px;"),
               box(plotOutput(outputId = "age_plot", height = 250), 
                   width = 5, height = 325)
             )
      ),
      column(4,
             box(leafletOutput(outputId = "admissions_ae", height = 645),
                 width = NULL, height = 670)
      )
    ),
    
    fluidRow(
      column(3),
      column(6,
             tabBox(tabPanel("BBC News", 
                             tags$h1("'Emergency department patients are waiting longer'"), 
                             tags$a("BBC News website", 
                                    href = "https://www.bbc.com/news/uk-scotland-58641817"), 
                             tags$i("Our analyses confirms that this quote is true.")),
                    tabPanel("The Observer", "Quote"),
                    width = NULL),
             column(3)
      )
    )
  )
)

