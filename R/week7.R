# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)
library(GGally)
# library()
# library()

# Data Import and Cleaning
week7_tbl <- read_csv("../data/week3.csv", col_names = TRUE) %>%  #used read_csv as in csv format
  mutate(
    timeStart = ymd_hms(timeStart), # recoded TimeStart as a POSIXct; Note: timeEnd already in POSIXct
    timeEnd = ymd_hms(timeEnd), # could use this just to be safe
    condition = factor(condition, levels = c("A", "B", "C"), labels = c("Block A", "Block B", "Control")), # factor coded condition according to Table 1
    gender = factor(gender, levels = c("M", "F"), labels = c("Male", "Female")), # factor coded gender according to Table 1
    timeSpent = timeEnd - timeStart, #diffdate = difference between two time points
    across(q1:q10, as.integer) # Sets q1-q10 as integer
  ) %>% 
  filter(q6 == 1) %>% # Retains only those that answered `1` to q6 (manipulation check)
  select(-q6) # Removes q6

# Visualization
(ggpairs(week7_tbl, columns = 5:13, lower = list(continuous = "points"), upper = list(continuous = "cor"), diag = list(continuous = "densityDiag"))) %>% 
  ggsave(filename = "../figs/ggally.fig.png", height=6, width=8, units="in", dpi=600)

(ggplot(week7_tbl, aes(timeStart, q1)) + 
    geom_point() +
    xlab("Date of Experiment") +
    ylab("Q1 Score") +
    labs(title = "Fig 1")) %>%
  ggsave(filename = "../figs/fig1.png", height=6, width=8, units="in", dpi=600)
(ggplot(week7_tbl, aes(q1, q2, color = gender)) +
    geom_point(position = "jitter") +
    labs(title = "Fig 2", color = "Participant Gender")) %>% 
  ggsave(filename = "../figs/fig2.png", height=6, width=8, units="in", dpi=600)

(ggplot(week7_tbl, aes(q1, q2)) +
    geom_point(position = "jitter") +
    facet_grid(cols = vars(gender)) + 
    xlab("Score on Q1") +
    ylab("Score on Q2") +
    labs(title = "Fig 3")) %>% 
  ggsave(filename = "../figs/fig3.png", height=6, width=8, units="in", dpi=600)
(ggplot(week7_tbl, aes(gender, timeSpent)) +
    geom_boxplot() +
    xlab("Gender") +
    ylab("Time elapsed (mins)") +
    labs(title = "Fig 4")) %>% 
  ggsave(filename = "../figs/fig4.png", height=6, width=8, units="in", dpi=600)
(ggplot(week7_tbl, aes(q5, q7, color = condition)) + 
    geom_point(position = "jitter") +
    stat_smooth(method = "lm", se = FALSE) +
    theme(
      legend.position = "bottom",
      legend.background = element_rect(fill = "grey85")
    ) +
    xlab("Score on Q5") +
    ylab("Score on Q7") +
    labs(title = "Fig 5", color = "Experimental Condition")) %>% 
  ggsave(filename = "../figs/fig5.png", height=6, width=8, units="in", dpi=300)
