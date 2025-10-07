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


## Create store ----

phdegree_store_location <- "ph_degree.duckdb"

phdegree_store <- ragnar::ragnar_store_create(
  location = phdegree_store_location,
  embed = \(x) ragnar::embed_ollama(x = x, model = "snowflake-arctic-embed2:568m"),
  overwrite = TRUE
)


## Ingest degree information ----

### Set 1 ----
message("Reading information from degrees 1 to 20")
process_degrees(.url = ph_master_programme_links[1:20], store = phdegree_store)

message("Pausing ingest for 30 seconds")
Sys.sleep(30)

### Set 2 ----
message("Reading information from degrees 21 to 40")
process_degrees(.url = ph_master_programme_links[21:40], store = phdegree_store)

message("Pausing ingest for 30 seconds")
Sys.sleep(30)

### Set 3 ----
message("Reading information from degrees 41 to 60")
process_degrees(.url = ph_master_programme_links[41:60], store = phdegree_store)

message("Pausing ingest for 30 seconds")
Sys.sleep(30)

### Set 4 ----
message("Reading information from degrees 61 to 80")
process_degrees(.url = ph_master_programme_links[61:80], store = phdegree_store)

message("Pausing ingest for 30 seconds")
Sys.sleep(30)

### Set 5 ----
message("Reading information from degrees 81 to 100")
process_degrees(.url = ph_master_programme_links[81:100], store = phdegree_store)

message("Pausing ingest for 30 seconds")
Sys.sleep(30)

### Set 6 ----
message("Reading information from degrees 101 to 120")
process_degrees(.url = ph_master_programme_links[101:120], store = phdegree_store)

message("Pausing ingest for 30 seconds")
Sys.sleep(30)

### Set 7 ----
message("Reading information from degrees 121 to 140")
process_degrees(.url = ph_master_programme_links[121:140], store = phdegree_store)

### Set 8 ----
message("Reading information from degrees 141 to 160")
process_degrees(.url = ph_master_programme_links[141:160], store = phdegree_store)

### Set 9 ----
message("Reading information from degrees 161 to 180")
process_degrees(.url = ph_master_programme_links[161:180], store = phdegree_store)

### Set 10 ----
message("Reading information from degrees 181 to 200")
process_degrees(.url = ph_master_programme_links[181:200], store = phdegree_store)

### Set 11 ----
message("Reading information from degrees 201 to 220")
process_degrees(.url = ph_master_programme_links[201:220], store = phdegree_store)

### Set 12 ----
message("Reading information from degrees 221 to 240")
process_degrees(.url = ph_master_programme_links[221:240], store = phdegree_store)

### Set 13 ----
message("Reading information from degrees 241 to 260")
process_degrees(.url = ph_master_programme_links[241:260], store = phdegree_store)

### Set 14 ----
message("Reading information from degrees 261 to 280")
process_degrees(.url = ph_master_programme_links[261:280], store = phdegree_store)

### Set 15 ----
message("Reading information from degrees 281 to 300")
process_degrees(.url = ph_master_programme_links[281:300], store = phdegree_store)

### Set 16 ----
message("Reading information from degrees 301 to 320")
process_degrees(.url = ph_master_programme_links[301:320], store = phdegree_store)

### Set 17 ----
message("Reading information from degrees 321 to 333")
process_degrees(.url = ph_master_programme_links[321:333], store = phdegree_store)

### Index store ----
ragnar_store_build_index(phdegree_store)


## Send duckdb to Google Drive ----

# db_gdrive_upload(
#   db = "phdegree.duckdb",
#   name = "phdegree.duckdb",
#   gdrive_id = db_gdrive_id
# )


## Release duckdb database to GitHub ----

#release_rag_db(file = "ph_degree.duckdb", name = "ph_degree.duckdb")
