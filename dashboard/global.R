library(tidyverse)
library(here)
library(janitor)
library(sf)
library(shiny)
library(shinydashboard)
library(leaflet)
library(plotly)

source(here("R/cleaning_script.R"))

about_info_1 <- "In late 2019, as word spread of the emergence of a virus with unknown 
severity and infectiousness across the globe so too did the very same virus; COVID-19. 
Government authorities appeared to stumble and stutter in response, some less 
so than others, in efforts to maintain the health and well-being of their countries."

about_info_2 <- "In this interactive dashboard the effects of the pandemic will be highlighted in 
particular to the National Health Service of Scotland. 
The data is open source from Public Health Scotland and ranges from early 
2016 to early 2021. The aim is to convey an understanding of the seasonal 
'winter crisis' NHS Scotland experiences every year and how the respiratory disease 
has impacted the acute sector within hospitals around the country."