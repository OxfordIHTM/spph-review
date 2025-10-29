# Analysis targets -------------------------------------------------------------


module_targets <- tar_plan(
  tar_target(
    name = modules_core,
    command = get_modules(ph_review_data)
  ),
  tar_target(
    name = module_categories,
    command = categorise_modules(modules_core, model = "deepseek-r1:14b")
  )
)
