# Setup RAG --------------------------------------------------------------------


## Load libraries and custom functions ----
suppressPackageStartupMessages(source("packages.R"))
for (f in list.files(here::here("R"), full.names = TRUE)) source (f)


## Load targets ----

tar_load(ph_master_programme_links)
tar_load(db_gdrive_id)


## Create store ----

phdegree_store_location <- "phdegree.duckdb"

phdegree_store <- ragnar::ragnar_store_create(
  location = phdegree_store_location,
  embed = \(x) ragnar::embed_ollama(x = x, model = "snowflake-arctic-embed2:568m"),
  overwrite = TRUE
)


## Ingest degree information ----

### Set 1 ----
process_degrees(.url = ph_master_programme_links[1:111], store = phdegree_store)

### Set 2 ----
process_degrees(.url = ph_master_programme_links[112:222], store = phdegree_store)

### Set 3 ----
process_degrees(.url = ph_master_programme_links[223:333], store = phdegree_store)

ragnar_store_build_index(phdegree_store)


## Send duckdb to Google Drive ----

db_gdrive_upload(
  db = "phdegree.duckdb",
  name = "phdegree.duckdb",
  gdrive_id = db_gdrive_id
)