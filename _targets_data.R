# Data targets -----------------------------------------------------------------


## QS world university rankings ----

qs_data_targets <- tar_plan(
  qs_gdrive_id = "1lF7k_hcm6FyNGJhV7p4x6JEdTOGnDpEy",
  tar_target(
    name = qs_gdrive_list,
    command = qs_get_overall_gdrive_list(qs_gdrive_id)
  ),
  tar_target(
    name = qs_overall_rankings_download_file,
    command = qs_download_overall_rankings(
      qs_gdrive_file = qs_gdrive_list,
      destdir = "data-raw/qs"
    ),
    pattern = map(qs_gdrive_list)
  ),
  tar_target(
    name = qs_overall_rankings_list,
    command = qs_read_overall_rankings(
      qs_file = qs_overall_rankings_download_file
    ),
    pattern = map(qs_overall_rankings_download_file),
    iteration = "list"
  ),
  #qs_variable_names = qs_create_variable_names(),
  tar_target(
    name = qs_overall_rankings,
    command = qs_process_overall_rankings(qs_overall_rankings_list),
    pattern = map(qs_overall_rankings_list)
  )
)


## THE world university rankings ----

the_data_targets <- tar_plan(
  
)


## ASPPH membership ----

aspph_data_targets <- tar_plan(
  aspph_members_directory_url = "https://aspph.org/membership/member-directory/",
  tar_target(
    name = aspph_members_list,
    command = aspph_extract_members_list(.url = aspph_members_directory_url)
  )
)


## ASPHER membership -----

aspher_data_targets <- tar_plan(
  aspher_members_directory_url = "https://www.aspher.org/users.html?&etykieta=4&str=",
  aspher_members_pages = seq_len(14),
  tar_target(
    name = aspher_members_list_raw,
    command = aspher_extract_members_list(
      .url = aspher_members_directory_url, page = aspher_members_pages
    ),
    pattern = map(aspher_members_pages)
  ),
  tar_target(
    name = aspher_members_list,
    command = aspher_process_members_list(aspher_members_list_raw)
  )
)

