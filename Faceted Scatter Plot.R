# Load required libraries
library(tidyverse)

# Assuming 'music_data' is already loaded and cleaned
# Create energy categories (low, medium, high)
music_data <- music_data %>%
  mutate(
    energy_category = case_when(
      energy <= 0.33 ~ "Low Energy",
      energy <= 0.66 ~ "Medium Energy",
      TRUE ~ "High Energy"
    )
  )

# Faceted scatter plot
plot_facet <- ggplot(music_data, aes(x = loudness, y = valence, color = valence)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", color = "red", se = FALSE) +
  scale_color_viridis_c(name = "Valence") +
  facet_wrap(~ energy_category, scales = "free", ncol = 3) +
  labs(
    title = "Faceted Scatter Plot of Loudness vs Valence by Energy Levels",
    subtitle = "Each panel represents a specific range of energy",
    x = "Loudness (dB)",
    y = "Valence"
  ) +
  theme_minimal()

# Display plot in RStudio plot section
print(plot_facet)

# Save plot to file
ggsave("C:/DS/loudness_valence_energy_facet.png", plot_facet, width = 12, height = 6)

