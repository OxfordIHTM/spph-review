# Iterate on RAG ingest --------------------------------------------------------

## Load libraries and custom functions ----
# suppressPackageStartupMessages(source("packages.R"))
# for (f in list.files(here::here("R"), full.names = TRUE)) source (f)


## Load targets ----

#tar_load(ph_master_programme_links)

process_degrees(.url = ph_master_programme_links[156:340], store = phdegree_store)

### Index store ----
ragnar_store_build_index(phdegree_store)
