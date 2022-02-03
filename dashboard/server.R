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
            axis.title = element_text(size = 8, colour = "grey15"))
    ggplotly(p) %>% config(displayModeBar = F)
  })
  
  output$admissions_ae <- renderLeaflet({
    
    admissions_ae %>%
      filter(str_detect(month, ("20210[1-3]")))  %>%
      leaflet() %>%
      addProviderTiles(providers$CartoDB.Positron) %>%
      addControl("A&E Volume per Location Over Winter 2020-21", position = "bottomright") %>% 
      addLegend(labels = ~ health_board,
                colors = ~pal(health_board),
                position = "topright") %>% 
      addCircles(lng = ~X,
                 lat = ~Y,
                 color = ~ pal(health_board),
                 weight = 10,
                 radius = ~number_of_attendances_aggregate,
                 popup = ~ location_name
                 popup = ~ full_address
      )
  })
  
  output$simd_quarter <- renderPlot({
    
    if(input$admission_input == "All"){
      simd_quarter %>%
        group_by(quarter, simd) %>%
        summarise(stays = sum(stays)) %>%
        ggplot(aes(x = quarter, y = stays, 
                   colour = as.factor(simd), group = simd)) +
        geom_line() +
        scale_color_manual(values = cbbPalette) +
        scale_y_continuous(labels = scales::comma_format()) +
        labs(
          x = "Quarter",
          y = "Total Stays",
          colour = "SIMD"
        ) +
        theme_minimal() +
        theme(axis.text.x = element_text(angle = 45, hjust = 1),
              axis.title = element_text(colour = "grey15"))
    } else {
      simd_quarter %>%
        filter(admission_type == input$admission_input) %>%
        group_by(quarter, simd) %>%
        summarise(stays = sum(stays)) %>%
        ggplot(aes(x = quarter, y = stays, 
                   colour = as.factor(simd), group = simd)) +
        geom_line() +
        scale_color_manual(values = cbbPalette) +
        scale_y_continuous(labels = scales::comma_format()) +
        labs(
          x = "\nQuarter",
          y = "Total Stays\n",
          colour = "SIMD"
        ) +
        theme_minimal() +
        theme(axis.text.x = element_text(angle = 45, hjust = 1),
              axis.title = element_text(colour = "grey15"))
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
                    label = format(total_stays, big.mark = ",")),
                colour = "white",
                size = 4.5) +
      scale_y_continuous(limits = c(0, 1070000),
                         labels = scales::comma_format()) +
      scale_fill_manual(values = c("indianred2", "steelblue")) +
      theme_minimal() +
      theme(axis.title = element_blank(),
            axis.text.x = element_text(size = 9),
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
      scale_y_continuous(limits = c(0, 450000),
                         labels = scales::comma_format()) +
      scale_fill_manual(values = c("grey80", "indianred2")) +
      labs(
        x = "Age (Years)",
        y = "Total Stays"
      ) +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
  })
}
