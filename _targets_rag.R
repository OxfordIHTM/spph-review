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
    command = duckdb::dbConnect(
      drv = duckdb::duckdb(), 
      dbdir = spph_review_store_location,
      read_only = TRUE
    )
  )
)


