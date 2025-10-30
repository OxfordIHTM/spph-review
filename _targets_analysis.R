# Analysis targets -------------------------------------------------------------


module_targets <- tar_plan(
  tar_target(
    name = ph_analysis_model,
    command = select_llm_model(src = "gpt-oss"),
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
    "Epidemiology and Biostatistics",
    "Qualitative Research Methods",
    "Health Promotion and Disease Prevention", 
    "Health Systems, Policy, and Governance", 
    "Leadership and Management Skills", 
    "Global Health and Development", 
    "Environmental Health and Sustainability",
    "Social Determinants of Health", 
    "Behavioural Sciences and Communication", 
    "Health Economics and Financing", 
    "Research Design and Evaluation", 
    "Ethical Considerations in Public Health", 
    "Disaster Response and Emergency Management"
  ),
  module_options_categories = c(
    "Health Economics and Financing",
    "Health Systems, Policy, and Governance", 
    "Epidemiology and Biostatistics", 
    "Infectious Disease, Outbreak Investigation, and One Health", 
    "Chronic and Non‑Communicable Disease Epidemiology", 
    "Environmental, Occupational, and Planetary Health", 
    "Nutrition, Dietetics, and Food Systems",
    "Health Promotion and Disease Prevention",
    "Behavioural Sciences and Communication", 
    "Implementation Science, Quality Improvement, and Program Evaluation", 
    "Clinical Research, Trials, and Meta‑analysis", 
    "Global Health and Development", 
    "Indigenous, Racial, Gender, and Minority Health Equity", 
    "Ethics, Law, and Human Rights in Public Health", 
    "Digital Health, Data Science, and Informatics", 
    "Leadership and Management Skills"
  ),
  tar_target(
    name = ph_modules_category,
    command = categorise_module(
      module = modules_core_expanded,
      module_categories = module_categories,
      model = ph_analysis_model
    ),
    pattern = map(modules_core_expanded)
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
      module_categories = module_option_categories,
      model = ph_analysis_model
    ),
    pattern = map(modules_option_expanded)
  )
)
