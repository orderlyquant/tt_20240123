library(tidyverse)

english_education <- readRDS("data/english_education.rds")
glimpse(english_education)


# recreate article plots -------------------------------------------------

# [article](https://www.ons.gov.uk/peoplepopulationandcommunity/educationandchildcare/articles/whydochildrenandyoungpeopleinsmallertownsdobetteracademicallythanthoseinlargertowns/2023-07-25)

english_education |>
  count(size_flag)

english_education <- english_education |>
  mutate(
    my_size_flag = case_when(
      str_detect(size_flag, "[Ll]ondon") ~ "London",
      size_flag == "City" ~ "City (excluding London)",
      TRUE ~ size_flag
    )
  )

valid_sizes <- c(
  "Small Towns",
  "Medium Towns",
  "Large Towns",
  "City (excluding London)",
  "London"
)

english_education |>
  filter(my_size_flag %in% valid_sizes) |>
  mutate(
    my_size_flag = factor(my_size_flag, levels = rev(valid_sizes))
  ) |>
  ggplot(aes(x = education_score, y = my_size_flag)) +
  geom_boxplot(alpha = 0.5, outliers = FALSE) +
  geom_jitter(size = 3.5, height = 0.2, color = "steelblue", alpha = 0.5) +
  xlim(-11, 11) +
  labs(
    title = "Smaller towns have the highest average educational attainment",
    subtitle = "Educational attainment score, by town size, England",
    caption = "Educational attainment index score",
    x = NULL,
    y = NULL
  ) +
  annotate(
    "text",
    x = c(-10, 10),
    y = 5.5,
    hjust = 1,
    label = c("lower attainment", "higher attainment")
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(face = "bold", size = 16),
    plot.subtitle = element_text(size = 12)
  )
