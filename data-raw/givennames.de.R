library(rvest)

current_year <- as.integer(format(Sys.time(), "%Y"))-1
years <- as.character(seq(1891, current_year))

trim <- function (x) gsub("^\\s+|\\s+$", "", x)

givennames.de <- data.frame()

for(year in years){

    url <- paste0("http://www.beliebte-vornamen.de/jahrgang/j", year)
    print(url)

    lists <- html(url) %>%  html_nodes(".entry table ol")

    list_f <- html_text(lists[1])
    list_m <- html_text(lists[2])
    list_f <- gsub("\r", "", list_f)
    list_m <- gsub("\r", "", list_m)

    names_f <- strsplit(list_f, "\n")[[1]]
    names_m <- strsplit(list_m, "\n")[[1]]

    names_f <- trim(names_f[nchar(names_f) >1])
    names_m <- trim(names_m[nchar(names_m) >1])

    tmp <- rbind( data.frame(name=names_f, sex="F"),  data.frame(name=names_m, sex="M"))

    sex <- "F"
    rank <- 1
    first <- F
    for(i in 1:nrow(tmp)){

     names <- trim(strsplit(as.character(droplevels(tmp[i, "name"])), "/")[[1]])
     sex <- tmp[i, "sex"]

     if(sex == "M" && !first){
       rank <- 1
       first <- T
     }

      for(j in seq_along(names)){
        givennames.de <- rbind(givennames.de, data.frame(name=names[j], rank=rank, sex=sex, year=year))
      }

     if(sex == "F" || first)
      rank <- rank + 1

    }

}

save(givennames.de, file = "data/givennames.de.rdata", compress = 'xz')
