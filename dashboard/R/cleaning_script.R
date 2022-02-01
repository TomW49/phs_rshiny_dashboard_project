library(tidyverse)
library(here)
library(janitor)
library(sf)


#-----------------------------------------------------------------------------#

# A&E admissions, Geospatial prep

# renaming variables
# removing S319H (Little France, Edinburgh Children hospital) as no coords
# removing unneeded cols
locations <- read_csv(here("../raw_data/nhs_medicalcentres.csv")) %>%
  clean_names() %>%
  rename(treatment_location = location, health_board = hb) %>% 
  filter(treatment_location != "S319H") %>%
  select(!c(1, 7:17))

# generating lat lon from British National Grid
coords <- locations %>%
  st_as_sf(coords = c("x_coordinate", "y_coordinate"), crs = 27700) %>%
  st_transform(4326) %>%
  st_coordinates() %>%
  as_tibble()

# removing unneeded cols
# renaming variables in health board for join
health_boards <- read_csv("../raw_data/nhs_healthboards.csv") %>%
  clean_names() %>%
  select(2:3) %>% 
  rename(health_board = hb)

# removing unneeded cols
admissions_ae <- 
  read_csv(here("../raw_data/monthly_a&e_activity_and_waiting_times.csv")) %>%
  clean_names() %>%
  select(!c(1, 3:4, 8:26))

# JOINING DATA

# joining lat lon data with hospital location
locations <- 
  bind_cols(locations, coords)

# joining locations with admissions
admissions_ae <- 
  left_join(admissions_ae, locations, by = "treatment_location")

# joining locations with health board
admissions_ae <- 
  left_join(admissions_ae, health_boards, by = "health_board" )

# joining locations with health board - can use this for future geospatial plots
nhs_scotland_medical_centre_loc <- 
  left_join(locations, health_boards, by = "health_board")

# removing locations as not required further for project 
rm(locations)
rm(health_boards)

#-----------------------------------------------------------------------------#

# Capacity

capacity_general <- 
  read_csv(here("../raw_data/bed_by_board_of_treatment_and_speciality.csv")) %>% 
  janitor::clean_names() %>%
  filter(is.na(location_qf),
         specialty_name == "All Acute")

#-----------------------------------------------------------------------------

#demographics
#count the numbwer of missing falue

age_sex %>%
  select(Age) %>%
  filter(is.na(age_sex)) %>%
  summarise(count_of_missing_age = n())