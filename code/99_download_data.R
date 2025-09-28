# Option 1: tidytuesdayR package
## install.packages("tidytuesdayR")

library(tidytuesdayR)

tuesdata <- tt_load('2024-01-23')
## OR
# tuesdata <- tidytuesdayR::tt_load(2024, week = 4)

english_education <- tuesdata$english_education

saveRDS(english_education, file = "data/english_education.rds")
