#'
#' Setup database
#' 

db_setup <- function(dbdir) {  
  duckdb::duckdb(dbdir = dbdir)

  store <- ragnar_store_create(
    location = "duckdb", 
    embed = function(x) ragnar::embed_ollama(
      x = x, model = "deepseek-r1:14b"
    ),
    overwrite = FALSE
  )


}