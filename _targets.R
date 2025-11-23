# Schools and Programmes of Public Health (SPPH) Review ------------------------


## Load libraries and custom functions ----
suppressPackageStartupMessages(source("packages.R"))
for (f in list.files(here::here("R"), full.names = TRUE)) source (f)


## Build options ----

### Google authorisation ----
googledrive::drive_deauth()
googlesheets4::gs4_deauth()


## Data targets ----
source("_targets_data.R")


## RAG targets ----
source("_targets_rag.R")


## Processing targets ----
processing_targets <- tar_plan(
  
)


## Analysis targets ----
source("_targets_analysis.R")


## Output targets ----
source("_targets_output.R")


## Release targets ----
source("_targets_release.R")


## Reporting targets ----
report_targets <- tar_plan(
  tar_quarto(
    name = mph_review_report,
    path = "reports/mph_review.qmd",
    working_directory = here::here(),
    quiet = FALSE,
    cue = tar_cue("always")
  )  
)


## Deploy targets ----
deploy_targets <- tar_plan(
  
)


## List targets ----
all_targets()
