# Exercise 8: exploring data sets

# Load the `dplyr` library

library(dplyr)
# Read in the data (from `data/pupulitzer-circulation-data.csv`). Remember to 
# not treat strings as factors!
pcd <- read.csv("data/pulitzer-circulation-data.csv", stringsAsFactors = F) 

# View in the data set. Start to understand what the data set contains
View(pcd)

# Print out the names of the columns for reference
colnames(pcd)

# Use the 'str()' function to also see what types of values are contained in 
# each column (you're looking at the second column after the `:`)
# Did any value type surprise you? Why do you think they are that type?
str(pcd)

# Add a column to the data frame called 'Pulitzer.Prize.Change` that contains 
# the difference in the number of times each paper was a winner or finalist 
# (hereafter "winner") during 2004-2014 and during 1990-2003
pcd <- mutate(pcd, Pulitzer.Prize.Change = 
                Pulitzer.Prize.Winners.and.Finalists..2004.2014 - 
                Pulitzer.Prize.Winners.and.Finalists..1990.2003
                )

# What was the name of the publication that has the most winners between 
# 2004-2014?
pcd %>% 
  filter(Pulitzer.Prize.Winners.and.Finalists..2004.2014 == 
           max(Pulitzer.Prize.Winners.and.Finalists..2004.2014)) %>% 
  select(Newspaper)

# Which publication with at least 5 winners between 2004-2014 had the biggest
# decrease(negative) in daily circulation numbers?
pcd %>% 
  filter(Pulitzer.Prize.Winners.and.Finalists..2004.2014 >= 5) %>%
  mutate(Change.in.Daily.Circulation..2004.2013 = 
           as.numeric(substr(Change.in.Daily.Circulation..2004.2013, 1, 
                             nchar(Change.in.Daily.Circulation..2004.2013)-1))) %>%
  filter(Change.in.Daily.Circulation..2004.2013 == 
           min(Change.in.Daily.Circulation..2004.2013)) %>% 
  select(Newspaper)

# An important part about being a data scientist is asking questions. 
# Write a question you may be interested in about this data set, and then use  
# dplyr to figure out the answer!

#What was the top five Pulizer Winners 2004.2014 total daily circulation in 2013

pcd %>% 
  arrange(desc(Pulitzer.Prize.Winners.and.Finalists..2004.2014)) %>% 
  slice(1:5) %>% 
  summarise(total_circulation = sum(as.numeric(gsub(",", "", Daily.Circulation..2013))))




