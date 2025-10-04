# RAG targets ------------------------------------------------------------------


## Setup data store for RAG ----

ph_store_targets <- tar_plan(
  ph_store = ragnar::ragnar_store_create(
    location = "phdegree.duckdb",
    embed = \(x) ragnar::embed_ollama(x = x, model = "snowflake-arctic-embed2:568m"),
    overwrite = TRUE
  )
)


## Degree list RAG targets ----

ph_master_rag_targets <- tar_plan(
  tar_target(
    name = ph_master_rag,
    command = process_degrees(
      .url = ph_master_programme_links, store = ph_store
    )
  )
)
