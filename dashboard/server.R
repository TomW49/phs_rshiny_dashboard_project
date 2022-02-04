server <- function(input, output) {
  
  output$capacity_plot <- renderPlotly({
    
    p <- capacity_general %>% 
      filter(specialty_name == input$specialty_input) %>% 
      group_by(quarter) %>% 
      summarise(avg = mean(percentage_occupancy)) %>%
      ggplot(aes(x = quarter, y = avg)) +
      geom_line(group = 1, colour = "steelblue") + 
      geom_point(colour = "steelblue") +
      scale_y_continuous(limits = c(0, 100),
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
      select(!c(1, 8:26)) %>% 
      filter(str_detect(month, ("202[0-1]0[1-3]"))) %>% 
      pivot_wider(names_from = month, 
                  names_prefix = "x", 
                  values_from = number_of_attendances_aggregate) %>%
      filter(department_type == "Emergency Department") %>%
      mutate(total_winter19_20 = (x202001 + x202002 + x202003)) %>% 
      mutate(total_winter20_21 = (x202101 + x202102 + x202103)) %>%
      leaflet() %>%
      addProviderTiles(providers$CartoDB.Positron) %>%
      addControl("A&E Volume Per Location Over Winter 2020-21",
                 position = "bottomleft") %>% 
      addLegend(labels = ~ hb_name_colours$hb_name,
                colors = ~ hb_name_colours$value,
                position = "topright") %>% 
      addCircles(lng = ~X,
                 lat = ~Y,
                 color = ~ pal(health_board),
                 weight = 10,
                 radius = ~total_winter19_20/2,
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
