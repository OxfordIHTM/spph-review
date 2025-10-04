# RAG targets ------------------------------------------------------------------


## Setup data store for RAG ----

ph_store_targets <- tar_plan(
  tar_target(
    name = llm_embed_model,
    command = select_llm_embed_model(src = "embed2:568m")
  ),
  ph_store_location = "phdegree.duckdb",
  ph_store = ragnar::ragnar_store_create(
    location = ph_store_location,
    embed = \(x) ragnar::embed_ollama(x = x, model = llm_embed_model),
    overwrite = TRUE
  )
)


## Degree list RAG targets ----

ph_master_rag_targets <- tar_plan(
  tar_target(
    name = ph_master_rag,
    command = process_degree_list(
      .url = ph_master_programme_links, store = ph_store
    ),
    pattern = map(ph_master_programme_links)
  )
)
