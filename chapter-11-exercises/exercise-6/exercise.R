# Exercise 6: dplyr join operations

# Install the `"nycflights13"` package. Load (`library()`) the package.
# You'll also need to load `dplyr`
#install.packages("nycflights13")  # should be done already
library("nycflights13")
library("dplyr")

# Create a dataframe of the average arrival delays for each _destination_, then 
# use `left_join()` to join on the "airports" dataframe, which has the airport
# information
# Which airport had the largest average arrival delay?
flights %>% 
  group_by(dest) %>% 
  summarise(avg_arr_delay = mean(arr_delay, na.rm = T)) %>% 
  left_join(airports, by = c("dest" = "faa")) %>%
  filter(avg_arr_delay == max(avg_arr_delay, na.rm = T)) %>% 
  select(name)

# Create a dataframe of the average arrival delay for each _airline_, then use
# `left_join()` to join on the "airlines" dataframe
# Which airline had the smallest average arrival delay?
flights %>% 
  group_by(carrier) %>% 
  summarise(avg_arr_delay = mean(arr_delay, na.rm = T)) %>% 
  left_join(airlines) %>% 
  filter(avg_arr_delay == min(avg_arr_delay, na.rm = T))
