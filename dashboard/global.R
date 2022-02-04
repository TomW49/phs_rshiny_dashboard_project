library(tidyverse)
library(here)
library(janitor)
library(sf)
library(shiny)
library(shinydashboard)
library(leaflet)
library(plotly)

source(here("R/cleaning_script.R"))

about_info_1 <- "In late 2019, as word spread rapidly across the globe about the 
discovery of a virus with unknown severity and reprecussions, so too did the 
virus itself. It was the disease that we have become much familiar with and has 
infected almost every aspect of our lives: COVID-19. Government authorities 
appeared to stumble and stutter in response, some less so than others, in efforts
to maintain the health and well-being of their countries."

about_info_2 <- "In this interactive dashboard the effects of the pandemic will 
be highlighted in particular to the National Health Service of Scotland. 
The data is open source from Public Health Scotland and ranges from early 
2016 to early 2021. The aim is to convey an understanding of the seasonal 
'winter crisis' NHS Scotland experiences every year and how the respiratory 
disease has impacted the acute sector within hospitals around the country."

figure_1 <- "Figure 1: Level 1 SIMD had the highest amount of stays across 2016-2020."

figure_2 <-  "Figure 2: Bed occupancy decreased by 18% in 2020 Q2 and is increasing again."

figure_3 <- "Figure 3: Females are more likely to stay in hospital in winter"

figure_4 <- "Figure 4: The main age brakcet effected by winter across 4 years is 70-79 years"