ui <- dashboardPage(
  dashboardHeader(title = "NHS Scotland - \"The Winter Crisis\"",
                  titleWidth = 350),
  dashboardSidebar(disable = TRUE),
  dashboardBody(
    
    fluidRow(
      column(8,
             box(about_info_1,br(),br(),
                 about_info_2,
                 title = "Introduction",
                 width = NULL)
      ),
      column(4,
             box(img(src = "phs-logo.png", 
                     height = "180", 
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
      
      infoBox("2016-2020 winter admissions ", 
              value = "Males aged 70-79", 
              "Were the biggest driver of hospital activity ", 
              width = 3,
              color = "light-blue",
              icon = icon("mars")),
      
      infoBox("2016-2020 winter admissions", 
              value = "SIMD 1 = 25% of total stays", 
              " Level 1 Were the most common cohort",
              width = 3,
              color = "light-blue",
              icon = icon("house-user")),
      
      infoBox("Inpatients 2020 winter", 
              value = "Females stayed 15% longer", 
              "On average than males in winter",
              width = 3,
              color = "light-blue",
              icon = icon("venus"))
    ),
    
    fluidRow(
      column(8,
             fluidRow(
               box("Figure 1: Total Count of Stays in Each Scottish Index of Multiple Deprivation (SIMD) Group (2016 - 2021)",
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
                                           "2021" = "2021Q1"),
                               selected = "2020Q1"),
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
                                           "2021" = "2021Q1"),
                               selected = "2020Q1"),
                   width = 5, height = 325, style = "font-size:12px;")
             )
      ),
      column(4,
             box(leafletOutput(outputId = "admissions_ae", height = 645),
                 width = NULL, height = 670)
      )
    ),
    
    fluidRow(
      column(6,
             box(title = "Conclusions",
                 figure_1 ,br(),
                 figure_2 ,br(),
                 figure_3 ,br(),
                 figure_4 ,br(),
                 width = NULL, height = 150)
      ),
      column(6,
             tabBox(tabPanel("BBC News", 
                             tags$h1("'Emergency department patients are waiting longer'"), 
                             tags$a("BBC News website", 
                                    href = "https://www.bbc.com/news/uk-scotland-58641817"), 
                             tags$i("Our findings behind this statement are correct, as we 
                                    uncovered a 7% increase in admissions within the Accident 
                                    and Emergency Departments. This seemingly small increase along with the introduction 
                                    of COVID-19 within hospitals has put immense pressure on the NHS across the nation.
                                    With the government now implementing enforced isolation staffing levels will inevitabley reduce
                                    adding further pressure on the service.")),
                    tabPanel("BBC News", 
                             tags$h1("'A 30%-50% positive test rate was routinely seen in the older age groups'"),
                             tags$a("BBC News website", 
                                    href = "https://www.bbc.co.uk/news/uk-scotland-54059199"), 
                             tags$i("Our analyses can align with this statement, as seen in Figure 4.
                                    Although specifically our data is prior to the COVID-19 pandemic,
                                    being within older age groups, it proves that by proxy they are the most vulnerable and highest affected group.")),
                    width = NULL)
      )
    )
  )
)

