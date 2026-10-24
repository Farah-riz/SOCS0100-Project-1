# ensure pacman is installed
if(!require("pacman")) {
  install.packages("pacman")
}

pacman::p_load(
  tidyverse, # tidyverse pkgs including purrr
  kableExtra,#table
  flextable, #table
  skimr) #a broad overview of data frame 

options(scipen=999) # to see full digits instead of enums

# 1) import
# import data EMDAT.csv
data <- read.csv("EMDAT.csv", header = TRUE)

# 3) inspect 
# what's the difference?
glimpse(data) # columns run down the page, and data runs across - list of vars
skim(data) # includes summary stats and dtypes - broad overview

# to see as table, can also click spreadsheet button in Data tab
View(data)

# 4) select
# select only the fields you need and rename to be more intuitive
df <- data %>% 
  select(Entity, Year, deaths_all_disasters,injured_all_disasters,homeless_all_disasters) %>%
  rename(deaths = deaths_all_disasters, injuries = injured_all_disasters, homelessness = homeless_all_disasters, country = Entity)

glimpse(df)

# 5) averages

averages <- df %>%
  filter(!country %in% c("World","Soviet Union")) %>%
  group_by(country) %>%
  summarise(
    avg_deaths = mean(deaths, na.rm = TRUE),
    avg_injuries = mean(injuries, na.rm = TRUE),
    avg_homelessness = mean(homelessness, na.rm = TRUE)
  )
  

glimpse(averages)

# Create tables for the top 10 averages
top_10_deaths <- averages %>%
  arrange(desc(avg_deaths)) %>%
  head(10) %>% # cut off at 10 could use slice as well
  kable(caption = "Top 10 Countries by Average Deaths")
# Apply formatting
top_10_deaths %>%
  kable_styling("striped") %>%
  kable_classic(full_width = FALSE)

# repeat for other tables
top_10_injuries <- averages %>%
  arrange(desc(avg_injuries)) %>%
  head(10) %>%
  kable(caption = "Top 10 Countries by Average Injuries")
top_10_injuries %>%
  kable_styling("striped") %>%
  kable_classic(full_width = FALSE)

top_10_homelessness <- averages %>%
  arrange(desc(avg_homelessness)) %>%
  head(10) %>%
  kable(caption = "Top 10 Countries by Average Homelessness")
top_10_homelessness %>%
  kable_styling("striped") %>%
  kable_classic(full_width = FALSE)

# 6) Create a new binary variable in the original dataset to
#show whether the number of deaths by all disasters is higher than 500 in a given year

df <- df %>% mutate(high_death = ifelse(deaths > 500, 1, 0))

# 7) Reshape 
df_wide <- df %>%
  pivot_wider(
    names_from = Year,       # Specify the columns to pivot
    values_from = c(deaths, injuries, homelessness, high_death)  # Specify the values columns
  )
# Save the df_wide data frame as a separate R data set
saveRDS(df_wide, "df_wide.rds")
