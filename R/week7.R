# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)
# library()
# library()
# library()

# Data Import and Cleaning
week7_tbl <- read_csv("../data/week3.csv") %>% 
  mutate(
    timeStart = ymd_hms(timeStart),
    condition = factor(condition, levels = c("A", "B", "C"), labels = c("Block A", "Block B", "Control")),
    gender = factor(gender, levels = c("M", "F"), labels = c("Male", "Female")),
    timeSpent = timeEnd - timeStart,
    across(q1:q10, as.integer)
  ) %>% 
  filter(q6 == 1) %>%
  select(-q6)


# Visualization