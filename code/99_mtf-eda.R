library(tidyverse)
library(readxl)
library(janitor)

# Downloaded data for income deprivation scores from
# https://www.ons.gov.uk/peoplepopulationandcommunity/educationandchildcare/articles/whydochildrenandyoungpeopleinsmallertownsdobetteracademicallythanthoseinlargertowns/2023-07-25
att_dep_tbl <- read_excel("data/income-dep-data.xlsx", skip = 4) |>
  clean_names() |>
  select(educational_attainment_score, income_deprivation_score)


att_dep_plot <- att_dep_tbl |>
  ggplot(
    mapping = aes(educational_attainment_score, income_deprivation_score)
  ) +
  geom_point(
    alpha = 0.5,
    color = "steelblue"
  ) +
  labs(
    title = "Towns with the highest educational attainment have low levels of income deprivation",
    subtitle = "Educational attainment score of the 2012 to 2013 school year GCSE cohort, and income deprivation score, by town, England",
    x = "Educational attainment score",
    y = "Income deprivation score"
  ) +
  annotate(
    "text",
    x = -8,
    y = 0.95,
    label = "Lower deprivation"
  ) +
  annotate(
    "segment",
    x = -10.5,
    y = 0.92,
    yend = 0.98,
    arrow = arrow()
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(face = "bold")
  )

print(att_dep_plot)
