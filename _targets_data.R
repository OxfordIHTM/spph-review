# Data targets -----------------------------------------------------------------


## Setup data store for RAG ----

# db_store_targets <- tar_plan(
#   tar_target(
#     name = llm_embed_model,
#     command = select_llm_embed_model(src = "embed2:568m")
#   ),
#   db_store_location = "spph.duckdb",
#   db_store = ragnar::ragnar_store_create(
#     location = db_store_location,
#     embed = \(x) ragnar::embed_ollama(x = x, model = llm_embed_model)
#   )
# )


## World Bank data ----

wb_data_targets <- tar_plan(
  wb_income_download_url = "https://ddh-openapi.worldbank.org/resources/DR0095333/download",
  tar_target(
    name = wb_income_download_file,
    command = wb_download_income_groups(destdir = "data-raw/wb"),
    format = "file"
  ),
  tar_target(
    name = wb_income_groups,
    command = wb_read_income_groups(wb_file = wb_income_download_file)
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
  )
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
    name = sr_public_health_rankings_raw,
    command = readxl::read_xlsx(
      path = sr_ph_rankings_download_file,
      col_types = c(rep("text", 4), rep("numeric", 6))
    )
  ),
  tar_target(
    name = sr_public_health_rankings,
    command = sr_process_ph_rankings(
      sr_public_health_rankings_raw, wb_income_groups
    )
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
  )#,
  # aspher_members_info_link = aspher_members_list$link,
  # tar_target(
  #   name = aspher_members_info,
  #   command = aspher_process_member(
  #     .url = aspher_members_info_link, store = db_store
  #   ),
  #   pattern = map(aspher_members_info_link)
  # )
)


## UCLA ----

ucla_data_targets <- tar_plan(
  ucla_master_programme_base_link = "https://ph.ucla.edu/degrees-programs/find-compare-degree-programs?degree_program[]=198,202,199",
  ucla_master_programme_page = seq_len(3),
  tar_target(
    name = ucla_master_programme_links,
    command = ucla_get_master_programme_links(
      base_url = ucla_master_programme_base_link, 
      page = ucla_master_programme_page 
    ),
    pattern = map(ucla_master_programme_page)
  )
)


## HSPH ----

hsph_data_targets <- tar_plan(
  hsph_master_programme_base_link = "https://hsph.harvard.edu/program-finder/?pf_degree_type=masters-degrees",
  tar_target(
    name = hsph_master_programme_links,
    command = hsph_get_master_programme_links(.url = hsph_master_programme_base_link)
  )
)


## LSHTM ----

lshtm_data_targets <- tar_plan(
  lshtm_master_programme_base_link = "https://www.lshtm.ac.uk/study/courses/masters-degrees",
  lshtm_gdrive_id = "1NkGTly0dX4DKqmcMwZCuK_l-oiMLyR2e",
  tar_target(
    name = lshtm_master_programme_html_file,
    command = lshtm_gdrive_download(
      gdrive_id = lshtm_gdrive_id, file_path = "data-raw/lshtm/lshtm.html"
    ),
    format = "file"
  ),
  tar_target(
    name = lshtm_master_programme_links,
    command = lshtm_get_master_programme_links(
      .url = lshtm_master_programme_base_link, 
      html = lshtm_master_programme_html_file
    )
  )
)


## Yale School of Public Health ----

ysph_data_targets <- tar_plan(
  ysph_master_programme_base_link = "https://ysph.yale.edu/school-of-public-health/graduate-programs/",
  tar_target(
    name = ysph_master_programme_links,
    command = ysph_get_master_programme_links(.url = ysph_master_programme_base_link)
  )
)


## Columbia University Mailman School of Public Health ----

mail_data_targets <- tar_plan(
  mail_master_programme_base_link = "https://www.publichealth.columbia.edu/academics/degrees",
  tar_target(
    name = mail_master_programme_links,
    command = mail_get_master_programme_links(.url = mail_master_programme_base_link)
  )
)


## University of Michigan School of Public Health ----

mich_data_targets <- tar_plan(
  mich_master_programme_base_link = "https://sph.umich.edu/admissions/programs-degrees/masters/degrees-and-requirements.html",
  tar_target(
    name = mich_master_programme_links,
    command = mich_get_master_programme_links(
      .url = mich_master_programme_base_link
    )
  )
)


## UCL public health ----

ucl_data_targets <- tar_plan(
  ucl_master_programme_base_link = "https://www.ucl.ac.uk/population-health-sciences/study/postgraduate-taught-degrees",
  tar_target(
    name = ucl_master_programme_links,
    command = ucl_get_master_programme_links(
      .url = ucl_master_programme_base_link
    )
  )
)


## Johns Hopkins BSPH ----

bsph_data_targets <- tar_plan(
  bsph_master_programme_base_link = "https://publichealth.jhu.edu/academics/academic-program-finder/masters-degrees",
  tar_target(
    name = bsph_master_programme_links,
    command = bsph_get_master_programme_links(
      .url = bsph_master_programme_base_link
    )
  )
)


## UCSF public health ----

ucsf_data_targets <- tar_plan(
  ucsf_master_programme_base_link = "https://graduate.ucsf.edu/admission/programs",
  tar_target(
    name = ucsf_master_programme_links,
    command = ucsf_get_master_programme_links(
      .url = ucsf_master_programme_base_link
    )
  )
)


## Dalla Lana School of Public Health ----

dlsph_data_targets <- tar_plan(
  dlsph_master_programme_base_link = "https://www.dlsph.utoronto.ca/program-type/masters/",
  tar_target(
    name = dlsph_master_programme_links,
    command = dlsph_get_master_programme_links(
      .url = dlsph_master_programme_base_link
    )
  )
)


## University of Washington School of Public Health ----

wsph_data_targets <- tar_plan(
  wsph_master_programme_base_link = "https://sph.washington.edu/students/graduate-programs",
  tar_target(
    name = wsph_master_programme_links,
    command = wsph_get_master_programme_links(
      .url = wsph_master_programme_base_link
    )
  )
)


## UNC Gillings School of Public Health ----

gsph_data_targets <- tar_plan(
  gsph_master_programme_base_link = "https://sph.unc.edu/resource-pages/masters-degrees/",
  tar_target(
    name = gsph_master_programme_links,
    command = gsph_get_master_programme_links(
      .url = gsph_master_programme_base_link
    )
  )
)


## University of Sydney School of Public Health ----

sydn_data_targets <- tar_plan(
  sydn_master_programme_base_link = "https://www.sydney.edu.au/medicine-health/study-medicine-and-health/postgraduate-courses.html",
  tar_target(
    name = sydn_master_programme_links,
    command = sydn_get_master_programme_links(
      .url = sydn_master_programme_base_link
    )
  )
)


## HKU School of Public Health ----

hku_data_targets <- tar_plan(
  hku_master_programme_base_link = "https://www.mph.sph.hku.hk/programme-overview",
  tar_target(
    name = hku_master_programme_links,
    command = hku_get_master_programme_links(
      .url = hku_master_programme_base_link
    )
  )
)


## Rollins School of Public Health ----

emory_data_targets <- tar_plan(
  emory_master_programme_base_link = "https://sph.emory.edu/degrees-programs/explore-programs?keys=&field_program_type_target_id%5B1101%5D=1101&field_program_type_target_id%5B521%5D=521&field_program_type_target_id%5B526%5D=526",
  emory_master_programme_page = 0:1,
  tar_target(
    name = emory_master_programme_links,
    command = emory_get_master_programme_links(
      base_url = emory_master_programme_base_link, 
      page = emory_master_programme_page
    ),
    pattern = map(emory_master_programme_page)
  )
)


## Imperial College School of Public Health ----

imp_data_targets <- tar_plan(
  imp_master_programme_base_link = "https://www.imperial.ac.uk/school-public-health/study/postgraduate/masters/",
  tar_target(
    name = imp_master_programme_links,
    command = imp_get_master_programme_links()
  )
)


## UPenn Perelman School of Meeicine ----

upen_data_targets <- tar_plan(
  upen_master_programme_base_link = "https://www.med.upenn.edu/maccentral/masters-programs.html",
  tar_target(
    name = upen_master_programme_links,
    command = upen_get_master_programme_links(
      .url = upen_master_programme_base_link
    )
  )
)


## Stanford Public Health ----

stan_data_targets <- tar_plan(
  tar_target(
    name = stan_master_programme_links,
    command = stan_get_master_programme_links()
  )
)


## UNSW Master of Public Health ----

unsw_data_targets <- tar_plan(
  tar_target(
    name = unsw_master_programme_links,
    command = unsw_get_master_programme_links()
  )
)


## Erasmus University Rotterdam Public Health ----

eras_data_targets <- tar_plan(
  eras_master_programme_base_link = "https://www.eur.nl/en/education/master/overview?s=Public%20Health&f[0]=discipline%3A890&f[1]=mode%3A1261&f[2]=type%3Amaster",
  tar_target(
    name = eras_master_programme_links,
    command = eras_get_master_programme_links(
      .url = eras_master_programme_base_link
    )
  )
)


## University of Sao Paulo Public Health ----

usp_data_targets <- tar_plan(
  usp_master_programme_base_link = "https://www.fsp.usp.br/pos/",
  usp_gdrive_id = "1BqTkT1GcZ4qxUBEPWGGmHK4cvvatRzce",
  tar_target(
    name = usp_master_programme_html_file,
    command = usp_gdrive_download(
      gdrive_id = usp_gdrive_id, file_path = "data-raw/usp/usp.html"
    ),
    format = "file"
  ),
  tar_target(
    name = usp_master_programme_links,
    command = usp_get_master_programme_links(
      .url = usp_master_programme_base_link, 
      html = usp_master_programme_html_file
    )
  )
)


## University of Ottawa public health ----

uott_data_targets <- tar_plan(
  tar_target(
    name = uott_master_programme_links,
    command = uott_get_master_programme_links()
  )
)


## BUSPH ----

busph_data_targets <- tar_plan(
  busph_master_programme_base_link = "https://www.bu.edu/sph/education/degrees-and-programs/",
  tar_target(
    name = busph_master_programme_links,
    command = busph_get_master_programme_links(
      .url = busph_master_programme_base_link
    )
  )
)


## University of Melbourne public health ----

melb_data_targets <- tar_plan(
  melb_master_programme_base_link = "https://study.unimelb.edu.au/study-with-us/graduate-courses/health/public-health",
  tar_target(
    name = melb_master_programme_links,
    command = melb_get_master_programme_links(
      .url = melb_master_programme_base_link
    )
  )
)


## University of Bristol public health ----

brist_data_targets <- tar_plan(
  brist_master_programme_base_link = "https://www.bristol.ac.uk/study/postgraduate/search/?filterSchools=Bristol%20Medical%20School&page=1",
  tar_target(
    name = brist_master_programme_links,
    command = brist_get_master_programme_links(
      .url = brist_master_programme_base_link
    )
  )
)


## King's College public health ----

kcl_data_targets <- tar_plan(
  kcl_master_programme_base_link = "https://www.kcl.ac.uk/search/courses?level=postgraduate-taught&term=public%20health",
  tar_target(
    name = kcl_master_programme_links,
    command = kcl_get_master_programme_links(
      .url = kcl_master_programme_base_link
    )
  )
)


## Karolinska Institutet ----

karol_data_targets <- tar_plan(
  karol_master_programme_base_link = "https://education.ki.se/bachelors-masters-studies/masters-programmes",
  tar_target(
    name = karol_master_programme_links,
    command = karol_get_master_programme_links(
      .url = karol_master_programme_base_link
    )
  )
)


## University of British Columbia ----

ubc_data_targets <- tar_plan(
  ubc_master_programme_base_link = "https://spph.ubc.ca/education/",
  tar_target(
    name = ubc_master_programme_links,
    command = ubc_get_master_programme_links(
      .url = ubc_master_programme_base_link
    )
  )
)


## University of Queensland ----

queen_data_targets <- tar_plan(
  queen_master_programme_base_link = "https://study.uq.edu.au/study-options/programs?search=%22public%20health%22&type=program&level[Postgraduate]=Postgraduate&study_areas[14]=14&year=2026",
  tar_target(
    name = queen_master_programme_links,
    command = queen_get_master_programme_links(
      .url = queen_master_programme_base_link
    )
  )
)


## University of Oxford ----

ox_data_targets <- tar_plan(
  ox_master_programme_base_link = "https://www.ox.ac.uk/admissions/graduate/courses/courses-a-z-listing?keywords=Public+Health",
  tar_target(
    name = ox_master_programme_links,
    command = ox_get_master_programme_links(
      .url = ox_master_programme_base_link
    )
  )
)
