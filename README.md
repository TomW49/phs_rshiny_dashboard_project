# phs_rshiny_dashboard_project

# Public Health Scotland group project - PDA

Personal Development Award evidence for Scottish Qualifications Authority

## Background

The contents of this repo are a product of collective work produced by Mujtaba Khider, Emily Noone, Neringa Šiugždinytė and Tom Wightman as tasked to us by CodeClan. This will provide as evidence towards our PDA's and further experience in data manipulation, visualisation and working as part of a remote team on a project.

With data provided open source from the National Health Service (NHS) on areas not exhaustive of admissions demographic, type of admissions and bedspace, we have been tasked with developing and employing an interactive dashboard displaying this information. 

The overarching theme is to display the effect winter had on the health service in the year 2020, with an output to forecast the now retrospective winter of 2021. Considerations on the COVID-19 pandemic will be made along with the media's prediction of the "winter crisis" at that time.

## Languages/Technology 

This project will use R with R Studios, along with Git/Git Hub for version control.

## How to run the project

The application can be found in the *dashboard* folder and run through the *global.R* file.

**dashboard** - contains all files regarding the app, along with the *clean_data*.

**documentation** - files regarding planning and execution of group project are stored here.

**raw_data** - raw data taken from Public Health Scotland https://www.opendata.nhs.scot/ is stored here for communal access. Once prepared for use, a copy is made and stored in the *clean_data* folder.

**scripts** - these are any cleaning scripts used on the data for awareness of the user.

## Features/packages

* Tidyverse 1.3.1
    * ggplot2 3.3.5
    * purrr   0.3.4
    * tibble  3.1.6   
    * dplyr   1.0.7
    * tidyr   1.1.4     
    * stringr 1.4.0
    * readr   2.1.0     
    * forcats 0.5.1