# Exercise 3: using the pipe operator

# Install (if needed) and load the "dplyr" library
#install.packages("dplyr")
library("dplyr")

# Install (if needed) and load the "fueleconomy" package
#install.packages('devtools')
#devtools::install_github("hadley/fueleconomy")
library("fueleconomy")

# Which 2015 Acura model has the best hwy MGH? (Use dplyr, but without method
# chaining or pipes--use temporary variables!)
filtered <- filter(vehicles, year==2015, make=="Acura")
filtered <- filter(filtered, hwy == min(hwy))
select(filtered, model)
# Which 2015 Acura model has the best hwy MPG? (Use dplyr, nesting functions)
select(filter(filter(vehicles, year==2015, make=="Acura"), hwy==min(hwy)), model)

# Which 2015 Acura model has the best hwy MPG? (Use dplyr and the pipe operator)

vehicles %>% 
  filter(year==2015, make=="Acura") %>% 
  filter(hwy==min(hwy)) %>% 
  select(model)

### Bonus

# Write 3 functions, one for each approach.  Then,
# Test how long it takes to perform each one 1000 times
f_variables <- function(y, m) {
  filtered <- filter(vehicles, year==y, make==m)
  filtered <- filter(filtered, hwy == min(hwy))
  select(filtered, model)
}

f_nested <- function(y, m) {
  select(filter(filter(vehicles, year==y, make==m), hwy==min(hwy)), model)
}

f_pipe <- function(y, m) {
  vehicles %>% 
    filter(year==y, make==m) %>% 
    filter(hwy==min(hwy)) %>% 
    select(model)
}

test_time <- function(func) {
  t_start <- Sys.time()
  for (t in 1:1000){
    func(2015, "Acura")
  }
  t_end <- Sys.time()
  dif <- difftime(t_end, t_start, units = "secs")
  print(dif)
}



test_time(f_pipe)
