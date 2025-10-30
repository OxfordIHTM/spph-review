# Analysis targets -------------------------------------------------------------


module_targets <- tar_plan(
  tar_target(
    name = ph_analysis_model,
    command = select_llm_model(src = "gpt-oss"),
    cue= tar_cue("always")
  ),
  tar_target(
    name = ph_review_data_expanded,
    command = expand_module(ph_review_data, type = "core")
  ),
  modules_core_expanded = ph_review_data_expanded$modules_core,
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
  module_categories = c(
    "Foundations in Public Health",
    "Quantitative Research Methods",
    "Epidemiology and Statistics",
    "Qualitative Research Methods",
    "Health Promotion and Disease Prevention", 
    "Health Systems, Policy, and Governance", 
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
  tar_target(
    name = ph_modules_category,
    command = categorise_module(
      module = modules_core_expanded,
      module_categories = module_categories,
      model = ph_analysis_model
    ),
    pattern = map(modules_core_expanded)
  )
)
