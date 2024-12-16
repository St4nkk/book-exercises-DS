# Exercise 1: accessing a relational database

# Install and load the `dplyr`, `DBI`, and `RSQLite` packages for accessing
# databases
pacman::p_load(dplyr, DBI, RSQLite)

# Create a connection to the `Chinook_Sqlite.sqlite` file in the `data` folder
# Be sure to set your working directory!
db_conn <- dbConnect(SQLite(), dbname = "data/Chinook_Sqlite.sqlite")

# Use the `dbListTables()` function (passing in the connection) to get a list
# of tables in the database.
dbListTables(db_conn)

# Use the `tbl()`function to create a reference to the table of music genres.
# Print out the the table to confirm that you've accessed it.
genre <- tbl(db_conn, "Genre")

# Try to use `View()` to see the contents of the table. What happened?
View(genre)

# Use the `collect()` function to actually load the genre table into memory
# as a data frame. View that data frame.
genre_df <- collect(genre)

# Use dplyr's `count()` function to see how many rows are in the genre table
rows <- count(genre_df)


# Use the `tbl()` function to create a reference the table with track data.
# Print out the the table to confirm that you've accessed it.
track <- tbl(db_conn, "Track")

# Use dplyr functions to query for a list of artists in descending order by
# popularity in the database (e.g., the artist with the most tracks at the top)
# - Start by filting for rows that have an artist listed (use `is.na()`), then
#   group rows by the artist and count them. Finally, arrange the results.
# - Use pipes to do this all as one statement without collecting the data into
#   memory!
track %>% 
  filter(!is.na(Composer)) %>% 
  group_by(Composer) %>%
  summarise(tracks_num = count(TrackId)) %>% 
  arrange(desc(tracks_num)) 

# Use dplyr functions to query for the most popular _genre_ in the library.
# You will need to count the number of occurrences of each genre, and join the
# two tables together in order to also access the genre name.
# Collect the resulting data into memory in order to access the specific row of
# interest
genre_by_tracks <- collect(
  track %>% 
  filter(!is.na(GenreId)) %>% 
  group_by(GenreId) %>% 
  summarise(num_of_tracks = count(TrackId)) %>% 
  left_join(genre, by="GenreId") %>% 
  arrange(desc(num_of_tracks)) )

most_popular_genre <- top_n(genre_by_tracks, n=1, num_of_tracks)
# Bonus: Query for a list of the most popular artist for each genre in the
# library (a "representative" artist for each).
# Consider using multiple grouping operations. Note that you can only filter
# for a `max()` value if you've collected the data into memory.
most_popular_artist_by_genre <- collect(
  track %>% 
  filter(!is.na(GenreId), !is.na(Composer)) %>% 
  group_by(GenreId, Composer) %>%
  summarise(num_of_track = count(TrackId)) %>% 
  filter(num_of_track == max(num_of_track, na.rm = T)) %>% 
  left_join(genre, by="GenreId")  )

# Remember to disconnect from the database once you are done with it!
dbDisconnect(db_conn)
