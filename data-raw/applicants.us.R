library(RCurl)
library(XML)
library(tidyr)

usbirths <- getURL("https://www.ssa.gov/oact/babynames/numberUSbirths.html")

usbirths <- readHTMLTable(usbirths)[[2]]
names(usbirths) <- c("year", "M", "F", "total")
usbirths <- usbirths[-1, ]

usbirths$year <- as.integer(as.character(usbirths$year))
usbirths$M <- as.integer(gsub(",", "", usbirths$M))
usbirths$F <- as.integer(gsub(",", "", usbirths$F))
usbirths$total <- as.integer(gsub(",", "", usbirths$total))

applicants.us <- gather(usbirths, sex, count, M:F)
applicants.us$sex <- as.character(applicants$sex)

save(applicants.us, file = "data/applicants.us.rdata", compress = 'xz')
