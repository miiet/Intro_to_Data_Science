# Load required libraries
library(tidyverse)
library(reshape2)  # For reshaping data
library(ggplot2)   # For visualization

# Assuming 'music_data' is already loaded and cleaned
# Select numeric columns for correlation
numeric_columns <- music_data %>%
  select(valence, loudness, speechiness, instrumentalness, tempo, danceability, energy, acousticness) %>%
  drop_na()

# Calculate the correlation matrix
correlation_matrix <- cor(numeric_columns)

# Convert the correlation matrix into a tidy format for ggplot2
correlation_data <- as.data.frame(as.table(correlation_matrix))

# Dynamic threshold for significant correlations
significance_threshold <- 0.25  # Adjust this value as needed
correlation_data <- correlation_data %>%
  mutate(Significant = ifelse(abs(Freq) > significance_threshold, TRUE, FALSE))

# Highlight features: valence, danceability, and energy
highlight_features <- c("valence", "danceability", "energy")

# Create the heatmap with dynamic significance and multiple focus features
ggplot(correlation_data, aes(x = Var1, y = Var2, fill = Freq)) +
  geom_tile(color = "white") +
  geom_text(
    aes(label = ifelse(Significant, round(Freq, 2), "")),  # Display only significant correlations
    color = "black", size = 3.5
  ) +
  scale_fill_gradient2(
    low = "green", 
    mid = "white", 
    high = "red", 
    midpoint = 0, 
    name = "Correlation"
  ) +
  labs(
    title = "Enhanced Heatmap of Feature Correlations",
    x = "Features",
    y = "Features"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, size = 12),  # Increase font size
    axis.text.y = element_text(size = 12),  # Increase font size
    plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),  # Center and style title
    legend.title = element_text(size = 12),
    legend.text = element_text(size = 10)
  ) +
  # Highlight specific rows and columns for focus features
  geom_tile(
    data = subset(correlation_data, Var1 %in% highlight_features | Var2 %in% highlight_features),
    aes(x = Var1, y = Var2),
    fill = NA, color = "black", size = 1.2
  )

