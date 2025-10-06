# Release workflow artifacts and outputs ---------------------------------------


release_targets <- tar_plan(
  tar_target(
    name = gha_db_release,
    command = release_rag_db(file = "ph_degree.duckdb", name = "ph_degree.duckdb")
  )
)