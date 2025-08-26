# Chunk 1: Load packages or datasets
library(dplyr)

band_members

# Chunk 2: General R code chunk
band_instruments

# Chunk 3: Full join example
full_join(band_members, band_instruments, by = join_by(name))

# Chunk 4: Inner join example
inner_join(band_members, band_instruments, by = join_by(name))

# Chunk 5: Left join example
left_join(band_members, band_instruments, by = join_by(name))

# Chunk 6: Right join example
right_join(band_members, band_instruments, by = join_by(name))

# Chunk 7: Inner join example
inner_join(band_members, band_instruments)

# Chunk 8: Inner join example
band_members %>% 
  mutate(band= toupper(band)) %>%
  inner_join(band_instruments, by = join_by(name))

# Chunk 9: Display mtcars dataset
mtcars

# Chunk 10: Summarise ungrouped mtcars
#  summarise() applied to ungrouped tbl returns a single row:
mtcars %>%
  summarise(mean = mean(disp), n = n()) # compute mean and sample size

# Chunk 11: Summarise mtcars by cyl
# Usually, you'll want to group first
mtcars %>%
  group_by(cyl) %>%
  summarise(mean = mean(disp), n = n())

# Chunk 12: Install and summarise flights dataset
install.packages("nycflights13")
library(nycflights13)
flights %>% str  

flights$carrier %>% unique %>% sort

flights %>%
  group_by(carrier) %>%
  summarise(avg_delay = mean(dep_delay, na.rm = TRUE))

# Chunk 13: Generic ggplot syntax template
my_data %>% ggplot( aes(...) ) + 
  geom_xxx(...) + 
  additional_option1(...) + 
  additional_option2(...)

# Chunk 14: Boxplot of delays by carrier
# a boxplot of dep_delay by carrier with jitter points
library(ggplot2)
flights %>% ggplot(aes(x = carrier, y = dep_delay , color= carrier)) +
  geom_boxplot(outliers = FALSE) +
  labs(title = "Departure Delay by Carrier",
       x = "Carrier",
       y = "Departure Delay (minutes)")

# Chunk 15: Scatterplot of delay vs month
# scatter plot of departure delay against month of the year
flights %>% ggplot(aes(x = month, y = dep_delay, color = carrier)) +
  geom_jitter() +
  labs(title = "Departure Delay by Month and Carrier",
       x = "Month",
       y = "Departure Delay (minutes)")

# Chunk 16: Line plot of average delays
# first group_by() carier and month then compute mean with summarise
flights %>%
  group_by(carrier, month) %>%
  summarise(avg_delay = mean(dep_delay, na.rm = TRUE)) %>%
  ggplot(aes(x = month, y = avg_delay, color = carrier)) +
  geom_line() +
  labs(title = "Average Departure Delay by Month and Carrier",
       x = "Month",
       y = "Average Departure Delay (minutes)")

# Chunk 17: Faceted line plot of average delays
# first group_by() carier and month 
# then compute mean with summarise
# then plot the average delays as a line plot with facets by carrier
flights %>%
  group_by(carrier, month) %>%
  summarise(avg_delay = mean(dep_delay, na.rm = TRUE)) %>%
  ggplot(aes(x = month, y = avg_delay, color = carrier)) +
  geom_line() + 
  facet_wrap(~ carrier) +
  labs(title = "Average Departure Delay by Month and Carrier",
       x = "Month",
       y = "Average Departure Delay (minutes)")
