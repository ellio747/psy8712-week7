# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)
# library()
# library()
# library()

# Data Import and Cleaning
week7_tbl <- read_csv("../data/week3.csv", col_names = TRUE) %>%  #used read_csv as in csv format
  mutate(
    timeStart = ymd_hms(timeStart), # recoded TimeStart as a POSIXct; Note: timeEnd already in POSIXct
    condition = factor(condition, levels = c("A", "B", "C"), labels = c("Block A", "Block B", "Control")), # factor coded condition according to Table 1
    gender = factor(gender, levels = c("M", "F"), labels = c("Male", "Female")), # factor coded gender according to Table 1
    timeSpent = timeEnd - timeStart, #diffdate = difference between two time points
    across(q1:q10, as.integer) # Sets q1-q10 as integer
  ) %>% 
  filter(q6 == 1) %>% # Retains only those that answered `1` to q6 (manipulation check)
  select(-q6) # Removes q6


# Visualization