# check if user has pacman
if(!require("pacman")) {
  install.packages("pacman")
}

pacman::p_load(
  tidyverse,
  kableEtxtra,
  flextable,
  skimr
)

#options(scipen=999) #to see full digits instead of enums

# import data EMDAT.csv
data <- read.csv("EMDAT.csv", header = TRUE)

# what's the difference?
skim(data)
glimpse(data)

# to see as table, can also click spreadsheet button in Data tab
View(data)

# select only the fields you need and rename to be more intuitive
df <- data %>% select(Entity, Year, deaths_all_disasters,injured_all_disasters,homeless_all_disasters) %>%
  rename(deaths = deaths_all_disasters, injuries = injured_all_disasters, homelessness = homeless_all_disasters, country = Entity)

glimpse(df)

# 5) calculate averages

averages <- df %>%
  filter(!country %in% c("",""))

