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
      labs(
        x = "\nQuarter",
        y = "Occupancy\n",
        title = "Quarterly Hospital Occupancy (2016 - 2021)\n"
      ) +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1),
            axis.title = element_text(colour = "grey15"),
            plot.title = element_text(colour = "grey25"))
  })
  
  output$admissions_ae <- renderPlot({
    
    admissions_ae %>%
      filter(str_detect(month, c("202101", "202102", "202103")))  %>%
      leaflet() %>%
      addTiles() %>%
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
      theme(axis.text.x = element_text(angle = 90)) +
      labs(
        x = "\nQuarter and Year",
        y = "Count of individuals in each SIMD\n",
        colour = "SIMD",
        title = "The count of individuals in each SIMD across 2016 Q2 -2021 Q2",
        subtitle = "Deprivation levels: 1(Most Deprived) - 5(Least Deprived)\n"
      )
  })
}
