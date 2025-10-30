# Analysis targets -------------------------------------------------------------


module_targets <- tar_plan(
  tar_target(
    name = ph_analysis_model,
    command = select_llm_model(src = "deepseek"),
    cue = tar_cue("always")
  ),
  tar_target(
    name = ph_review_data_expanded,
    command = expand_module(ph_review_data, type = "core")
  ),
  modules_core_expanded = ph_review_data_expanded$modules_core,
  tar_target(
    name = ph_review_data_expanded_options,
    command = expand_module(ph_review_data, type = "option")
  ),
  modules_option_expanded = ph_review_data_expanded_options$modules_options,
  tar_target(
    name = modules_core,
    command = get_modules(ph_review_data)
  ),
  tar_target(
    name = module_categories_extract,
    command = create_module_categories(
      modules_core, model = ph_analysis_model
    )
  ),
  tar_target(
    name = modules_options,
    command = get_modules_options(ph_review_data)
  ),
  tar_target(
    name = module_option_categories_extract,
    command = create_module_categories(
      modules_options, model = ph_analysis_model
    )
  ),
  module_categories = c(
    "Foundations in Public Health",
    "Quantitative Research Methods",
    "Epidemiology and Statistics",
    "Qualitative Research Methods",
    "Health Promotion and Disease Prevention", 
    "Health Systems",
    "Health Policy and Governance", 
    "Leadership and Management Skills", 
    "Global Health and Development", 
    "Environmental Health and Sustainability",
    "Social Determinants of Health", 
    "Behavioural Sciences and Communication", 
    "Health Economics and Finance", 
    "Research Design and Evaluation", 
    "Ethical Considerations in Public Health", 
    "Disaster Response and Emergency Management", 
    "Introduction to Global Health"
  ),
  module_options_categories = c(
    "Health Economics and Financing",
    "Health Systems, Policy, and Governance", 
    "Epidemiology and Biostatistics", 
    "Infectious Disease, Outbreak Investigation, and One Health",  
    "Chronic and Non-Communicable Disease Epidemiology", 
    "Environmental Health",
    "Occupational Health",
    "Planetary Health", 
    "Nutrition and Dietetics",
    "Nutrition and Food Systems",
    "Health Promotion and Disease Prevention",
    "Behavioural Sciences and Communication", 
    "Implementation Science",
    "Quality Improvement and Program Evaluation", 
    "Clinical Research and Trials",
    "Global Health and Development", 
    "Indigenous Health",
    "Gender and Health", 
    "Racial and Minority Health Equity", 
    "Law and Human Rights in Public Health",
    "Ethics in Public Health", 
    "Digital Health", 
    "Health Data Science",
    "Health Informatics", 
    "Leadership and Management Skills"
  ),
  tar_target(
    name = ph_modules_core_category,
    command = categorise_module(
      module = modules_core_expanded,
      module_categories = module_categories,
      model = ph_analysis_model
    ),
    pattern = map(modules_core_expanded)
  ),
  tar_target(
    name = ph_modules_option_category,
    command = categorise_module(
      module = modules_option_expanded,
      module_categories = module_options_categories,
      model = ph_analysis_model
    ),
    pattern = map(modules_option_expanded)
  ),
  tar_target(
    name = ph_review_data_processed,
    command = process_review_data(
      ph_review_data, sr_public_health_rankings,
      ph_modules_category, ph_modules_option_category
    )
  )
)
