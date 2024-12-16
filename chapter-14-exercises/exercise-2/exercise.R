# Exercise 2: working with data APIs

# load relevant libraries
library("httr")
library("jsonlite")

# Be sure and check the README.md for complete instructions!


# Use `source()` to load your API key variable from the `apikey.R` file you made.
# Make sure you've set your working directory!
source("apikeys.R")

# Create a variable `movie_name` that is the name of a movie of your choice.
book_name <- "Waiting+for+Godot"

# Construct an HTTP request to search for reviews for the given movie.
# The base URI is `https://api.nytimes.com/svc/movies/v2/`
# The resource is `reviews/search.json`
# See the interactive console for parameter details:
#   https://developer.nytimes.com/movie_reviews_v2.json
#
# You should use YOUR api key (as the `api-key` parameter)
# and your `movie_name` variable as the search query!

query_params <- list(
  title = book_name,
  'api-key' = nty_apikey
)
response <- GET("https://api.nytimes.com/svc/books/v3/reviews.json", query = query_params)
# Send the HTTP Request to download the data
# Extract the content and convert it from JSON
text_content <- content(response, "text")
book_review <- fromJSON(text_content)

# What kind of data structure did this produce? A data frame? A list?
typeof(book_review)

# Manually inspect the returned data and identify the content of interest 
# (which are the movie reviews).
# Use functions such as `names()`, `str()`, etc.
str(book_review)

# Flatten the movie reviews content into a data structure called `reviews`
godot_review <- book_review[["results"]]

# From the most recent review, store the headline, short summary, and link to
# the full article, each in their own variables
short_summary <- godot_review$summary[[1]]
link_to_article <- godot_review$url[[1]]
# Create a list of the three pieces of information from above. 
# Print out the list.
info_list <- list(
  'short summary' = short_summary,
  'article url' = link_to_article)

info_list
