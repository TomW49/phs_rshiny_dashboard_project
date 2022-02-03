library(janitor)
library(tidyverse)
library(ggplot2)


#I am going to look at the deprivation data and look at the count of each deprivation
deprivation_data <- read_csv(here::here("../raw_data/treatment_and_deprevation.csv"))
deprivation_data <- deprivation_data %>% clean_names()
head(deprivation_data) #I need to change the simd column to numeric otherwise it will be contiunious and we dont want that for the graph
tail(deprivation_data)
deprivation_data <- deprivation_data %>%
  filter(!is.na(simd)) #removing nas from here as we will be working with this variable often 

#changing simd to integer
deprivation_data <- deprivation_data %>%
  mutate(simd = as.factor(simd))

#looking at the total count of each simd
simd_graph <- deprivation_data %>%
  group_by(quarter, simd) %>%
  summarise(stays = sum(stays))

#making a set which looks at quarter and simd and groups them
simd_quarter_graph <- deprivation_data %>%
  group_by(quarter) %>%
  mutate()


#plotting each simd level and the total count in each qurter into a facet wrap
simd_quarter %>%
  ggplot() +
  aes(x = quarter, y = n, fill = simd) +
  geom_line(group = 1) +
  facet_wrap(~ simd) +
  theme(axis.text.x = element_text(angle = 90))

#I am going to create the final graph showing 

#------------------------------------------------------------------------------#

cbbPalette <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#D55E00", "#0072B2", "#D55E00", "#CC79A7")

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

#------------ edited graph

simd_graph %>%
  ggplot() +
  aes(x = quarter, y = stays, colour = as.factor(simd), group = simd) +
  geom_line() +
  scale_color_manual(values = cbbPalette) +
  scale_y_continuous(labels = scales::comma) +
  theme_light() +
  theme(axis.text.x = element_text(angle = 90)) +
  labs(
    x = "\nQuarter and Year",
    y = "Count of stays in each SIMD\n",
    colour = "SIMD",
    title = "The count of individuals in each SIMD across 2016 Q2 -2021 Q2",
    subtitle = "Deprivation levels: 1(Most Deprived) - 5(Least Deprived)\n"
  )
  
