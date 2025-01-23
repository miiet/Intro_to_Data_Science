# Load necessary libraries
library(ggplot2)
install.packages('ggpmisc')
library(ggpmisc)
library(viridis)

# Assuming music_data_clean is your dataset
# Create the plot
ggplot(music_data_clean, aes(x = loudness, y = valence, color = acousticness)) +
  geom_point(alpha = 0.6) +  # Add scatter points
  geom_smooth(method = "lm", aes(color = NULL), linetype = "dashed", se = FALSE) +  # Add regression line
  stat_poly_eq(
    aes(
      label = paste(..eq.label.., ..rr.label.., sep = "~~~")
    ),
    formula = y ~ x,
    parse = TRUE,
    label.x.npc = "right",
    label.y.npc = "top"
  ) +  # Add equation and R-squared
  scale_color_viridis_c() +  # Use a color scale for acousticness
  labs(
    title = "Regression Plot: Loudness and Acousticness vs Valence",
    x = "Loudness",
    y = "Valence",
    color = "Acousticness"
  ) +
  theme_minimal()
