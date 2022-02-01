server <- function(input, output) {
  
  output$capacity_plot <- renderPlot({
    
    capacity_general %>% 
      group_by(quarter) %>% 
      summarise(avg = mean(percentage_occupancy)) %>% 
      ggplot(aes(x = quarter, y = avg)) +
      geom_line(group = 1, colour = "steelblue") + 
      geom_point(colour = "steelblue") +
      geom_text(data = percentage_label,
                aes(label = str_c(round(avg), "%")),
                nudge_y = 2.3,
                nudge_x = 0.3,
                colour = "steelblue") +
      scale_y_continuous(limits = c(50, 100),
                         labels = scales::percent_format(scale = 1)) +
      scale_x_discrete(labels = c("2016Q2" = "16 Q2",
                       "2016Q3" = "Q3",
                       "2016Q4" = "Q4",
                       "2017Q1" = "17 Q1",
                       "2017Q2" = "Q2",
                       "2017Q3" = "Q3",
                       "2017Q4" = "Q4",
                       "2018Q1" = "17 Q1",
                       "2018Q2" = "Q2",
                       "2018Q3" = "Q3",
                       "2018Q4" = "Q4",
                       "2019Q1" = "17 Q1",
                       "2019Q2" = "Q2",
                       "2019Q3" = "Q3",
                       "2019Q4" = "Q4",
                       "2020Q1" = "17 Q1",
                       "2020Q2" = "Q2",
                       "2020Q3" = "Q3",
                       "2020Q4" = "Q4",
                       "2021Q1" = "17 Q1",
                       "2021Q2" = "Q2")) +
      labs(
        x = "Quarter",
        y = "Occupancy",
        title = "Quarterly Hospital Occupancy (2016 - 2021)"
      ) +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1),
            axis.title = element_text(colour = "grey15"),
            plot.title = element_text(colour = "grey25"))
  })
  
  output$admissions_ae <- renderLeaflet({
    
    admissions_ae %>%
      filter(str_detect(month, c("202101", "202102", "202103")))  %>%
      leaflet() %>%
      addProviderTiles(providers$CartoDB.Positron) %>%
      addCircles(lng = ~X,
                 lat = ~Y,
                 color = ~ pal(health_board),
                 weight = 10,
                 radius = ~number_of_attendances_aggregate,
                 popup = ~ location_name
      )
  })
  
  output$simd_quarter <- renderPlot({
    
    simd_quarter %>%
      ggplot(aes(x = quarter, y = n, colour = as.factor(simd), group = simd)) +
      geom_line() +
      scale_color_manual(values = cbbPalette) +
      theme_light() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
      labs(
        x = "Quarter and Year",
        y = "Count of individuals in each SIMD",
        colour = "SIMD",
        title = "The count of individuals in each SIMD across 2016 Q2 -2021 Q2",
        subtitle = "Deprivation levels: 1(Most Deprived) - 5(Least Deprived)"
      )
  })
  
  output$age_plot <- renderPlot({
    
    demographics_age %>% 
      ggplot(aes(x = age, y = total_stays)) +
      geom_col(aes(fill = age),
               show.legend = FALSE) +
      labs(
        x = "Age Group",
        y = "Total Stays",
        title = ""
      ) +
      theme_minimal()
  })
  
  output$sex_plot <- renderPlot({
    
    demographics_sex %>% 
      ggplot(aes(x = sex, y = total_stays)) +
      geom_col(aes(fill = sex),
               show.legend = FALSE) +
      labs(
        x = "Sex",
        y = "Total Stays",
        title = ""
      ) +
      theme_minimal()
  })
}