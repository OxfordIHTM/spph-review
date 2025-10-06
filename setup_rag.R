# Setup RAG --------------------------------------------------------------------


## Load libraries and custom functions ----
suppressPackageStartupMessages(source("packages.R"))
for (f in list.files(here::here("R"), full.names = TRUE)) source (f)


## Build options ----

### Google authorisation ----
googledrive::drive_deauth()
googlesheets4::gs4_deauth()


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
message("Reading information from degrees 1 to 50")
process_degrees(.url = ph_master_programme_links[1:50], store = phdegree_store)

### Set 2 ----
message("Reading information from degrees 51 to 100")
process_degrees(.url = ph_master_programme_links[51:100], store = phdegree_store)

### Set 3 ----
message("Reading information from degrees 101 to 150")
process_degrees(.url = ph_master_programme_links[101:150], store = phdegree_store)

### Set 4 ----
message("Reading information from degrees 151 to 200")
process_degrees(.url = ph_master_programme_links[151:200], store = phdegree_store)

### Set 5 ----
message("Reading information from degrees 201 to 250")
process_degrees(.url = ph_master_programme_links[201:250], store = phdegree_store)

### Set 6 ----
message("Reading information from degrees 251 to 300")
process_degrees(.url = ph_master_programme_links[251:300], store = phdegree_store)

### Set 7 ----
message("Reading information from degrees 301 to 333")
process_degrees(.url = ph_master_programme_links[301:333], store = phdegree_store)

### Index store ----
ragnar_store_build_index(phdegree_store)


## Send duckdb to Google Drive ----

# db_gdrive_upload(
#   db = "phdegree.duckdb",
#   name = "phdegree.duckdb",
#   gdrive_id = db_gdrive_id
# )


## Release duckdb database to GitHub ----

#release_rag_db(file = "phdegree.duckdb", name = "phdegree.duckdb")
