# Release workflow artifacts and outputs ---------------------------------------


release_targets <- tar_plan(
  tar_target(
    name = gha_db_release,
    command = release_rag_db(
      file = "spph_review.duckdb", name = "spph_review.duckdb"
    )
  )
)