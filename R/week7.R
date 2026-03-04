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

ggplot(week7_tbl, aes(timeStart, q1)) + 
  geom_point() +
  xlab("Date of Experiment")+
  ylab("Q1 Score")+
  labs(title = "Fig 1")

ggplot(week7_tbl, aes(q1, q2, color = gender)) +
  geom_point(position = "jitter") +
  labs(title = "Fig 2")









ggplot(week7_tbl, aes(gender, timeSpent)) +
  geom_boxplot() +
  xlab("Gender") +
  ylab("Time elapsed (mins)") +
  labs(title = "Fig 4")

ggplot(week7_tbl, aes(q5, q7, color = condition)) + 
  geom_point(position = "jitter") +
  stat_smooth(method = "lm", se = FALSE) +
  theme(
    legend.position = "bottom",
    legend.background = element_rect(fill = "#E0E0E0")
    ) +
  xlab("Score on Q5") +
  ylab("Score on Q7") +
  labs(title = "Fig 5")
