##Dataset of first names (given names) by popularity around of the world

##Installation

    library(devtools)
    install_github("ampaho/givennames")


##Applications
Tell us how this dataset was helpful to you by emailing us at houdan [at] jolome.com.

* This dataset was primarily created for gender detection after NER 

##Available data.frame
###givennames.us
All the first names given to babies in the US from 1880, the count and the decade.

A data frame with 4 variables: **name**, **sex**, **count** and **year**.

###givennames.fr
Top First names given to babies in France from  1950, the count and the decade.

A data frame with 4 variables: **name**, **sex**, **count** and **decade**.

###givennames.de
Top First names given to babies in Germany from 1891, the count and the decade.

A data frame with 4 variables: **name**, **rank**, **sex** and **year**.

###applicants.us
First names of SSA applicants.

A data frame with 4 variables: **year**, **total**, **sex** and **count**.
