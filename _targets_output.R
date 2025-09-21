# Output targets ---------------------------------------------------------------


## Output Shanghai Rankings ----

sr_output_targets <- tar_plan(
  tar_target(
    name = sr_public_health_rankings_csv,
    command = write_csv_file(
      x = sr_public_health_rankings, 
      file = "data/sr/sr_public_health_rankings.csv"
    ),
    format = "file"
  )
)