library(rvest)
library(tidyr)

decades <- as.character(seq(1950, 2010, by=10))
number_pages <- c(56, 69, 84, 113, 133, 170, 213)

number_pages_by_decades <- as.list(number_pages)
names(number_pages_by_decades) <- decades

givennames.fr <- data.frame()

for(decade in decades){

  nb_pages <- number_pages_by_decades[[decade]]
  for(page in 1:nb_pages){
    url <- paste0("http://www.journaldesfemmes.com/prenoms/cgi/classement/classement.php?f_id_localisation=1&f_annee=", decade,"&f_page=", page)
    table <- html(url) %>%  html_node("#contenu table")
    table <- readHTMLTable(table)
    table <- table[-1,]

    table_male <- table[, c(3, 4)]
    names(table_male) <- c("name", "count")
    table_male$sex <- "M"
    table_male$decade <- decade

    if(dim(table)[2] < 6)
    next
    else if(dim(table)[2] == 10)
    table_female <- table[, c(9, 10)]
    else
    table_female <- table[, c(8, 9)]

    names(table_female) <- c("name", "count")
    table_female$sex <- "F"
    table_female$decade <- decade

    givennames.fr <- rbind(givennames.fr, table_male, table_female)

  }

}

givennames.fr$count <- as.integer(as.character(givennames.fr$count))
givennames.fr <- givennames.fr[!is.na(givennames.fr$name),]
givennames.fr <- givennames.fr[, c(1,3,2,4)]

save(givennames.fr, file = "data/givennames.fr.rdata", compress = 'xz')
