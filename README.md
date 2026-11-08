# SOCS0100-Project-1
Week 3 Lab Exercise
- Learning how to use pacman to prevent intrusive downloading
- Exploring tidyverse packages

Uses the dataset “Natural disasters (EMDAT)”
Aggregated by Our World in Data by country and year based on the raw database of disasters published by EM-DAT, CRED / UCLouvain, Brussels, Belgium

disaster_problem_set.R :
- Imports and inspects EMDAT 
- Selects the variables that capture information related to deaths, injuries, homelessness caused by all disasters.
- Creates 3 tables showing the top 10 countries with the highest averages of those variables.
- Creates a new binary variable in the original dataset to show whether the number of deaths by all disasters is higher than 500 in a given year.
- Reshapes dataset from long to wide.

