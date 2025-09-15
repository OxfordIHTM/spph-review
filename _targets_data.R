# Data targets -----------------------------------------------------------------


## Setup data store for RAG ----

db_store_targets <- tar_plan(
  tar_target(
    name = llm_embed_model,
    command = select_llm_embed_model(src = "embed2:568m")
  ),
  db_store_location = "spph.duckdb",
  db_store = ragnar::ragnar_store_create(
    location = db_store_location,
    embed = \(x) ragnar::embed_ollama(x = x, model = llm_embed_model)
  )
)


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
    pattern = map(qs_gdrive_list),
    format = "file"
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
  ),

)


## THE world university rankings ----

the_data_targets <- tar_plan(
  the_gdrive_id = "1zem2pl6w1uJiN_IcJUaCr2COUBx6ur8I",
  tar_target(
    name = the_gdrive_ranking_download_links,
    command = the_gdrive_get_download_links(the_id = the_gdrive_id)
  ),
  tar_target(
    name = the_rankings_download_files,
    command = the_download_ranking_file(
      .url = the_gdrive_ranking_download_links, destdir = "data-raw/the"
    ),
    pattern = map(the_gdrive_ranking_download_links),
    format = "file"
  ),
  the_rankings_pdf_pages = the_set_ranking_pages(),
  tar_target(
    name = the_rankings_pdf_text,
    command = the_read_rankings(
      path = the_rankings_download_files, pages = the_rankings_pdf_pages
    ),
    pattern = map(the_rankings_download_files, the_rankings_pdf_pages),
    iteration = "list"
  ),
  tar_target(
    name = the_overall_rankings,
    command = the_process_rankings(the_rankings_pdf_text),
    pattern = map(the_rankings_pdf_text)
  )
)


## Shanghai Rankings - public health ----

sr_data_targets <- tar_plan(
  sr_gdrive_id = "1dy99Oednn28z1Q3DmSnQ8Ep4DgPoFgD6",
  tar_target(
    name = sr_ph_rankings_gdrive_list,
    command = sr_get_gdrive_list(sr_gdrive_id)
  ),
  tar_target(
    name = sr_ph_rankings_download_file,
    command = sr_download_ph_rankings(
      sr_gdrive_file = sr_ph_rankings_gdrive_list,
      destdir = "data-raw/sr"
    ),
    format = "file"
  ),
  tar_target(
    name = sr_public_health_rankings,
    command = readxl::read_xlsx(path = sr_ph_rankings_download_file)
  )
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
  ),
  aspher_members_info_link = aspher_members_list$link,
  tar_target(
    name = aspher_members_info,
    command = aspher_process_member(
      .url = aspher_members_info_link, store = db_store
    ),
    pattern = map(aspher_members_info_link)
  )
)




