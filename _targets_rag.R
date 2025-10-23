# RAG targets ------------------------------------------------------------------


## Setup data store for RAG ----

spph_store_targets <- tar_plan(
  spph_review_store_name = "spph_review.duckdb",
  tar_target(
    name = spph_review_store_location,
    command = spph_get_database(db_name = spph_review_store_name),
    format = "file"
  ),
  tar_target(
    name = spph_review_store,
    command = ragnar::ragnar_store_connect(location = spph_review_store_location),
    cue = targets::tar_cue("always")
  ),
  spph_model_name = "gpt-oss:120b",
  tar_target(
    name = spph_chat_client,
    command = ellmer::chat_ollama(model = spph_model_name),
    cue = tar_cue("always")
  )#,
  # tar_target(
  #   name = spph_review_prompt,
  #   command = ,
  # )
)
