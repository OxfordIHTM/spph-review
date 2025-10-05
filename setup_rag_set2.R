# Iterate on programme list ----------------------------------------------------


##

## Load libraries and custom functions ----
suppressPackageStartupMessages(source("packages.R"))
for (f in list.files(here::here("R"), full.names = TRUE)) source (f)


## Load targets ----

tar_load(ph_master_programme_links)


## Create store ----

phdegree_store_location <- "phdegree.duckdb"

##

x <- grep(
  pattern = "http://www.mphpublichealthpractice.uw.edu/",
  x = ph_master_programme_links
)

y <- ph_master_programme_links[x:length(ph_master_programme_links)]

process_degrees(.url = y, store = phdegree_store)

ragnar_store_build_index(phdegree_store)