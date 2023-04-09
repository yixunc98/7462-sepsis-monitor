### Task 1


library(tidyverse)
library(data.table) ## For the fread function
library(lubridate)

source("sepsis_monitor_functions.R")


### Task 2


library(tictoc)
patient <- c(50,100,500)
func <- c("fread","read_delim")
for (n in patient) {
  for (fn in func) {
    # Start the timer
    tic()
    
    # Call the makeSepsisDataset function
    makeSepsisDataset( n, fn)
    # Stop the timer and print the elapsed time
    toc()
  }
}


#### Answer: We can find the "fread" function is much faster than "read_delim".

### Task 3


library(googledrive)
df <- makeSepsisDataset()
# We have to write the file to disk first, then upload it
df %>% write_csv("sepsis_data_temp.csv")
# Uploading happens here
sepsis_file <- drive_put(media = "sepsis_data_temp.csv", 
                         path= "https://drive.google.com/drive/folders/1xgoRV0G4YGgVtZE4BvrTKqyX2kqzZnO6",
                         name = "sepsis_data.csv")
# Set the file permissions so anyone can download this file.
sepsis_file %>% drive_share_anyone()
