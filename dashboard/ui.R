ui <- dashboardPage(
  dashboardHeader(title = "NHS Scotland - \"The Winter Crisis\"",
                  titleWidth = 350),
  dashboardSidebar(disable = TRUE),
  dashboardBody(
    
    fluidRow(
      column(8,
             box(about_info,
                 title = "About",
                 width = NULL)
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
      infoBox("A&E 2020 winter admissions", 
              value = "7% Increase", "Since 2019 winter",
              width = 3,
              color = "light-blue",
              icon = icon("ambulance")),
      
      infoBox("Demographics winter admissions", 
              value = "Males aged 70-79", 
              "Every winter from 2016-2020", 
              width = 3,
              color = "light-blue",
              icon = icon("mars")),
      
      infoBox("Deprivation admissions", 
              value = "Level 3 (Medium deprivation)", "Every winter since 2016",
              width = 3,
              color = "light-blue",
              icon = icon("house-user")),
      
      infoBox("Average length of Stay between gender", 
              value = "Females stayed 15% longer ", "Winter 2020",
              width = 3,
              color = "light-blue",
              icon = icon("venus"))
    ),
    
    fluidRow(
      column(8,
             fluidRow(
               box("Figure 1: The Count of Individuals in Each SIMD Across 2016 Q2 - 2021 Q2",
                 plotOutput(outputId = "simd_quarter", height = 230),
                   selectInput("admission_input",
                               label = "Select Admission Type",
                               choices = c("All", simd_quarter %>% 
                                             distinct(admission_type) %>% 
                                             pull()),
                               width = NULL),
                   width = 8, height = 325, style = "font-size:12px;"),
               box("Figure 3: Winter Hopsitalisations by Sex",
                   plotOutput(outputId = "sex_plot", height = 230), 
                   selectInput("sex_year_input",
                               label = "Select Year",
                               choices = c("2017" = "2017Q1",
                                           "2018" = "2018Q1",
                                           "2019" = "2019Q1",
                                           "2020" = "2020Q1",
                                           "2021" = "2021Q1")),
                   width = 4, height = 325, style = "font-size:12px;")
             ),
             fluidRow(
               box("Figure 2: Quarterly Hospital Occupancy (2016 - 2021)",
                 plotlyOutput(outputId = "capacity_plot", height = 230),
                 selectInput("specialty_input",
                         label = "Select Specialty",
                         choices = capacity_general %>% 
                           distinct(specialty_name) %>% 
                           pull(),
                         width = NULL),
                   width = 7, height = 325, style = "font-size:12px;"),
               box("Figure 4: Winter Hospitalisations by Age Group",
                   plotOutput(outputId = "age_plot", height = 230), 
                   selectInput("age_year_input",
                               label = "Select Year",
                               choices = c("2017" = "2017Q1",
                                           "2018" = "2018Q1",
                                           "2019" = "2019Q1",
                                           "2020" = "2020Q1",
                                           "2021" = "2021Q1")),
                   width = 5, height = 325, style = "font-size:12px;")
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
                    tabPanel("BBC News", 
                             tags$h1("'A 30%-50% positive test rate was routinely seen in the older age groups'"),
                             tags$a("BBC News website", 
                                    href = "https://www.bbc.co.uk/news/uk-scotland-54059199"), 
                             tags$i("Our analyses confirms that this quote is true.")),
                    width = NULL),
             column(3)
      )
    )
  )
)

