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
        y = "Occupancy"
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
                 popup = ~ location_name)
  })
  
  output$simd_quarter <- renderPlot({
    
    if(input$admission_input == "All"){
      simd_quarter %>%
        filter(!is.na(simd)) %>%
        group_by(quarter) %>%
        count(simd) %>% 
        ggplot(aes(x = quarter, y = n, colour = as.factor(simd), group = simd)) +
        geom_line() +
        scale_color_manual(values = cbbPalette) +
        labs(
          x = "Quarter and Year",
          y = "Count of individuals in each SIMD",
          colour = "SIMD"
        ) +
        theme_light() +
        theme(axis.text.x = element_text(angle = 45, hjust = 1),
              axis.title = element_text(colour = "grey15"),
              plot.title = element_text(colour = "grey25"),
              plot.subtitle = element_text(colour = "grey25"))
    } else {
      simd_quarter %>%
        filter(!is.na(simd)) %>%
        group_by(quarter, admission_type) %>%
        count(simd) %>% 
        filter(admission_type == input$admission_input) %>%
        ggplot(aes(x = quarter, y = n, 
                   colour = as.factor(simd), group = simd)) +
        geom_line() +
        scale_color_manual(values = cbbPalette) +
        labs(
          x = "Quarter and Year",
          y = "Count of individuals in each SIMD",
          colour = "SIMD"
        ) +
        theme_light() +
        theme(axis.text.x = element_text(angle = 45, hjust = 1),
              axis.title = element_text(colour = "grey15"),
              plot.title = element_text(colour = "grey25"),
              plot.subtitle = element_text(colour = "grey25"))
    }
  })
  
  output$sex_plot <- renderPlot({
    
    demographics_sex %>% 
      filter(quarter == input$sex_year_input) %>% 
      group_by(sex) %>% 
      summarise(total_stays = sum(stays)) %>% 
      ggplot(aes(x = sex)) +
      geom_col(aes(y = total_stays, fill = sex),
               show.legend = FALSE) +
      geom_text(aes(y = total_stays * 0.95,
                    label = total_stays),
                colour = "white") +
      scale_y_continuous(labels = scales::comma_format()) +
      scale_fill_manual(values = c("indianred2", "steelblue")) +
      theme_minimal() +
      theme(axis.title = element_blank(),
            axis.text.y = element_blank())
  })
  
  output$age_plot <- renderPlot({
    
    demographics_age %>%
      filter(quarter == input$age_year_input) %>% 
      group_by(age) %>% 
      summarise(total_stays = sum(stays)) %>% 
      mutate(highest_age_group = if_else(total_stays == max(total_stays),
                                         TRUE,
                                         FALSE)) %>% 
      ggplot(aes(x = age, y = total_stays, fill = highest_age_group)) +
      geom_col(show.legend = FALSE) +
      scale_y_continuous(labels = scales::comma_format()) +
      scale_fill_manual(values = c("grey80", "indianred2")) +
      labs(
        x = "Age (Years)",
        y = "Total Stays"
      ) +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
  })
}
