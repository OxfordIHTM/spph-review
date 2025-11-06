# Output targets ---------------------------------------------------------------


## Output Rankings and Review dataset ----

output_targets <- tar_plan(
  tar_target(
    name = aspph_members_list_csv,
    command = write_csv_file(
      x = aspph_members_list,
      file = "data/aspph/aspph_members_list.csv"
    )
  ),
  tar_target(
    name = aspher_members_list_csv,
    command = write_csv_file(
      x = aspher_members_list,
      file = "data/aspher/aspher_members_list.csv"
    )
  ),
  tar_target(
    name = the_overall_rankings_csv,
    command = write_csv_file(
      x = the_overall_rankings,
      file = "data/the/the_overall_rankings.csv"
    )
  ),
  tar_target(
    name = qs_overall_rankings_csv,
    command = write_csv_file(
      x = qs_overall_rankings,
      file = "data/qs/qs_overall_rankings.csv"
    )
  ),
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