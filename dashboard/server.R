server <- function(input, output) {
  
  output$capacity_plot <- renderPlotly({
    
    p <- capacity_general %>% 
      filter(specialty_name == input$specialty_input) %>% 
      group_by(quarter) %>% 
      summarise(avg = mean(percentage_occupancy)) %>%
      ggplot(aes(x = quarter, y = avg)) +
      geom_line(group = 1, colour = "steelblue") + 
      geom_point(colour = "steelblue") +
      scale_y_continuous(limits = c(50, 100),
                         labels = scales::percent_format(scale = 1)) +
      labs(
        x = "Quarter",
        y = "Occupancy",
        title = "Quarterly Hospital Occupancy (2016 - 2021)"
      ) +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1),
            axis.text = element_text(size = 6),
            axis.title = element_text(size = 8, colour = "grey15"),
            plot.title = element_text(size = 10, colour = "grey25"))
    ggplotly(p) %>% config(displayModeBar = F)
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
      filter(!is.na(simd)) %>%
      filter(admission_type == input$admission_input) %>%
      ggplot(aes(x = quarter, y = n, colour = as.factor(simd), group = simd)) +
      geom_line() +
      scale_color_manual(values = cbbPalette) +
      labs(
        x = "Quarter and Year",
        y = "Count of individuals in each SIMD",
        colour = "SIMD",
        title = "The count of individuals in each SIMD across 2016 Q2 -2021 Q2",
        subtitle = "Deprivation levels: 1(Most Deprived) - 5(Least Deprived)"
      ) +
      theme_light() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1),
            axis.title = element_text(colour = "grey15"),
            plot.title = element_text(colour = "grey25"),
            plot.subtitle = element_text(colour = "grey25"))
  })

  output$age_plot <- renderPlot({
    
    demographics_age %>% 
      ggplot(aes(x = age, y = total_stays)) +
      geom_col(show.legend = FALSE) +
      labs(
        x = "Age (Years)",
        y = "Total Stays",
        title = "Hospitalisations period ber age"
      ) +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
  })
  
  output$sex_plot <- renderPlot({
    
    demographics_sex %>% 
      ggplot(aes(x = sex, y = total_stays)) +
      geom_col(aes(fill = sex),
               show.legend = FALSE) +
      labs(
        x = "Sex",
        y = "Total Stays",
        title = "Hospitalisations Period ber Gender"
      ) +
      theme_minimal()
  })
}
