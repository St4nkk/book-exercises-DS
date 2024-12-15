# Exercise 7: using dplyr on external data

# Load the `dplyr` library
library(dplyr)

# Use the `read.csv()` function to read in the included data set. Remember to
# save it as a variable.
ds <- read.csv("data/nba_teams_2016.csv", stringsAsFactors = F)

# View the data frame you loaded, and get some basic information about the 
# number of rows/columns. 
# Note the "X" preceding some of the column titles as well as the "*" following
# the names of teams that made it to the playoffs that year.
str(ds)

# Add a column that gives the turnovers to steals ratio (TOV / STL) for each team
ds <- mutate(ds, tov_to_stl_ratio = TOV / STL)

# Sort the teams from lowest turnover/steal ratio to highest
# Which team has the lowest turnover/steal ratio?
ds <- arrange(ds, tov_to_stl_ratio)
ds

# Using the pipe operator, create a new column of assists per game (AST / G) 
# AND sort the data.frame by this new column in descending order.
ds <- ds %>% 
  mutate(assist_per_game = AST / G) %>% 
  arrange(-assist_per_game)

# Create a data frame called `good_offense` of teams that scored more than 
# 8700 points (PTS) in the season
good_offense <- ds %>% filter(PTS >8700)

# Create a data frame called `good_defense` of teams that had more than 
# 470 blocks (BLK)
good_defense <- ds %>% filter(BLK > 470)

# Create a data frame called `offense_stats` that only shows offensive 
# rebounds (ORB), field-goal % (FG.), and assists (AST) along with the team name.
offense_stats <- ds %>% select(ORB, FG., AST, Team)

# Create a data frame called `defense_stats` that only shows defensive 
# rebounds (DRB), steals (STL), and blocks (BLK) along with the team name.
defense_stats <- ds %>% select(DRB, STL, BLK, Team)

# Create a function called `better_shooters` that takes in two teams and returns
# a data frame of the team with the better field-goal percentage. Include the 
# team name, field-goal percentage, and total points in your resulting data frame
better_shooters <- function(team1 ,team2) {
  ds %>% 
    filter(Team %in% c(team1, team2)) %>% 
    mutate(fg_perc = FG / G) %>% 
    filter(fg_perc == max(fg_perc)) %>% 
    select(Team, fg_perc, PTS )
}

# Call the function on two teams to compare them (remember the `*` if needed)
better_shooters("Golden State Warriors*", "Milwaukee Bucks")
