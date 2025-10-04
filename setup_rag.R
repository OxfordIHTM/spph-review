# Setup RAG --------------------------------------------------------------------


## Load targets ----

tar_load(ph_master_programme_links)


## Create store ----

phdegree_store_location <- "phdegree.duckdb"

phdegree_store <- ragnar::ragnar_store_create(
  location = phdegree_store_location,
  embed = \(x) ragnar::embed_ollama(x = x, model = "snowflake-arctic-embed2:568m"),
  overwrite = TRUE
)


## Ingest degree information ----

process_degrees(.url = ph_master_programme_links, store = phdegree_store)

