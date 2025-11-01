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
  ),
  tar_target(
    name = ph_master_programme_list_csv,
    command = write_csv_file(
      x = ph_master_programme_list,
      file = "data/ph_master_programme_list.csv"
    ),
    format = "file"
  ),
  tar_target(
    name = ph_review_data_processed_csv,
    command = write_csv_file(
      x = ph_review_data_processed,
      file = "data/ph_review_data_processed.csv"
    ),
    format = "file"
  )
)