#-----------------------------------------------------------------------------#

# A&E admissions, Geospatial prep

# renaming variables
# inputting coords for S319H (Little France, Edinburgh Children hospital) 
locations <- read_csv(here("../raw_data/nhs_medicalcentres.csv")) %>%
  clean_names() %>%
  rename(treatment_location = location, health_board = hb) %>% 
  mutate(x_coordinate = coalesce(x_coordinate, 328936),
         y_coordinate = coalesce(y_coordinate, 670399)) %>% 
  mutate(full_address = str_c(location_name, address_line, postcode, sep = ", "))

# generating lat lon from British National Grid
coords <- locations %>%
  st_as_sf(coords = c("x_coordinate", "y_coordinate"), crs = 27700) %>%
  st_transform(4326) %>%
  st_coordinates() %>%
  as_tibble()

# removing unneeded cols
locations <- locations %>% 
  select(!c(1, 7:17))

# removing unneeded cols
# renaming variables in health board for join
health_boards <- read_csv(here("../raw_data/nhs_healthboards.csv")) %>%
  clean_names() %>%
  select(2:3) %>% 
  rename(health_board = hb)

# removing unneeded cols
admissions_ae <- 
  read_csv(here("../raw_data/monthly_a&e_activity_and_waiting_times.csv")) %>%
  clean_names() 

# JOINING DATA

# joining lat lon data with hospital location
locations <- 
  bind_cols(locations, coords)

# joining locations with admissions
admissions_ae <- 
  left_join(admissions_ae, locations, by = "treatment_location")

# joining admissions with health board
admissions_ae <- 
  left_join(admissions_ae, health_boards, by = "health_board" )

# joining locations with health board - can use this for future geospatial plots
nhs_scotland_medical_centre_loc <- 
  left_join(locations, health_boards, by = "health_board") 

# creating colour palette for map denoting NHS health boards
hb_name_label <- admissions_ae %>% 
  filter(!is.na(hb_name)) %>% 
  distinct(hb_name)

colours <- as.tibble(c("#006b54", "#009e49", "#5bbf21",
                       "#00aa9e", "#00adc6", "#0091c9",
                       "#003893", "#56008c", "#a00054",
                       "#931638", "#d81e05", "#d81e05",
                       "#f7e214", "#c466ff"))

hb_name_colours <- bind_cols(hb_name_label, colours)

# removing locations as not required further for project 
rm(locations)
rm(health_boards)
rm(coords)
rm(colours)
rm(hb_name_label)

#-----------------------------------------------------------------------------#

# Capacity

# clean data

capacity_general <- 
  read_csv(here("../raw_data/bed_by_board_of_treatment_and_speciality.csv")) %>% 
  clean_names() %>%
  filter(is.na(location_qf),
         specialty_name_qf == "d")

# data for plot geom_text

percentage_label <- capacity_general %>% 
  mutate(q = case_when(
    str_detect(quarter, "Q1") ~ "Q1",
    str_detect(quarter, "Q2") ~ "Q2",
    str_detect(quarter, "Q3") ~ "Q3",
    str_detect(quarter, "Q4") ~ "Q4"
  )) %>%
  filter(q == "Q1") %>% 
  group_by(quarter) %>% 
  summarise(avg = mean(percentage_occupancy))

#-----------------------------------------------------------------------------#

#Deprivation data

#making a set which looks at quarter and simd and groups them
simd_quarter <- read_csv(here("../raw_data/treatment_and_deprevation.csv")) %>%
  clean_names() %>% 
  filter(!is.na(simd))

cbbPalette <- c("#000000", "#E69F00", "#56B4E9", 
                "#009E73", "#D55E00", "#0072B2", 
                "#D55E00", "#CC79A7")

#-----------------------------------------------------------------------------#

#demographics
#count the number of missing value

demographics <- 
  read_csv(here("../raw_data/treatment_age_and_sex.csv"))%>% 
  clean_names()
#filtering the data by age
demographics_sex <- demographics %>% 
  mutate(q = case_when(
    str_detect(quarter, "Q1") ~ "Q1",
    str_detect(quarter, "Q2") ~ "Q2",
    str_detect(quarter, "Q3") ~ "Q3",
    str_detect(quarter, "Q4") ~ "Q4"
  ))

# filtering the data by sex
demographics_age <- demographics %>% 
  mutate(q = case_when(
    str_detect(quarter, "Q1") ~ "Q1",
    str_detect(quarter, "Q2") ~ "Q2",
    str_detect(quarter, "Q3") ~ "Q3",
    str_detect(quarter, "Q4") ~ "Q4"
  )) %>%
  mutate(age = str_remove(age, " years(.*)"),
         age = if_else(age == "90",
                       "89<",
                       age))

