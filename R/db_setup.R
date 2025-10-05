#'
#' Setup database
#' 

db_setup <- function(dbdir, overwrite = FALSE) {
  dbdir_exists <- file.exists(dbdir)

  if (!dbdir_exists | overwrite) {
    ragnar::ragnar_store_create(
      location = dbdir,
      embed = \(x) ragnar::embed_ollama(
        x = x, model = "snowflake-arctic-embed2:568m"
      ),
      overwrite = overwrite
    )
  }
}