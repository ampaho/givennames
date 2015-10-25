download.file("https://www.ssa.gov/oact/babynames/names.zip", "data-raw/tmp-all-names")
files <- unzip("data-raw/tmp-all-names", exdir="data-raw/d-tmp-all-names")

years <- as.integer(unlist(lapply(files, function(x){gsub("[^0-9]{4}", "", x)} )))
years <- years[!is.na(years)]

givennames.us <- data.frame()

for(i in years){
  file <- paste0("data-raw/d-tmp-all-names/yob", i, ".txt")
  file.content <- read.csv(file, header = F, stringsAsFactors = F)
  file.content$year <- i
  givennames.us <- rbind(givennames.us, file.content)
}

message("Cleaning up")
unlink("data-raw/tmp-all-names")
unlink("data-raw/d-tmp-all-names", recursive = T, force = T)

names(givennames.us) <- c("name", "sex", "count", "year")

save(givennames.us, file = 'data/givennames.us.rdata', compress = 'xz')
