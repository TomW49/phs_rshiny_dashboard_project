
library(tidyverse)

# Capacity

capacity_general <- 
  read_csv("raw_data/bed_by_board_of_treatment_and_speciality.csv") %>% 
  janitor::clean_names() %>%
  filter(is.na(location_qf),
         specialty_name == "All Acute")