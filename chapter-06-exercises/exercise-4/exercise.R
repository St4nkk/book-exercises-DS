# Exercise 4: functions and conditionals

# Define a function `is_twice_as_long` that takes in two character strings, and 
# returns whether or not (e.g., a boolean) the length of one argument is greater
# than or equal to twice the length of the other.
# Hint: compare the length difference to the length of the smaller string

is_twice_as_long <- function(str1, str2) {
  min_len <- min(nchar(str1), nchar(str2))
  dif <- abs(nchar(str1)-nchar(str2))
  twice <- dif/min_len > 2
}
# Call your `is_twice_as_long` function by passing it different length strings
# to confirm that it works. Make sure to check when _either_ argument is twice
# as long, as well as when neither are!
(is_twice_as_long("abba", "c"))
(is_twice_as_long( "c", "abba"))
(is_twice_as_long( "cabas", "abba"))


# Define a function `describe_difference` that takes in two strings. The
# function should return one of the following sentences as appropriate
#   "Your first string is longer by N characters"
#   "Your second string is longer by N characters"
#   "Your strings are the same length!"
describe_difference <- function(str1, str2) {
  len1 <- nchar(str1)
  len2 <- nchar(str2)
  if (len1 > len2){
    N <- len1 - len2
    return(paste("Your first string is longer by", N, "characters"))
  } else if (len1 < len2) {
    N <- len2 - len1
    return(paste("Your second string is longer by", N, "characters"))
  } else {
    return("Your strings are the same length!")
  }
}

# Call your `describe_difference` function by passing it different length strings
# to confirm that it works. Make sure to check all 3 conditions1
(describe_difference("ass", "abs"))
(describe_difference("abss", "abs"))
(describe_difference("ass", "abbbs"))

