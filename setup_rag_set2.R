# Iterate on programme list ----------------------------------------------------


##

x <- grep(
  pattern = "https://www.onlinemph.uw.edu/",
  x = ph_master_programme_links
)

y <- ph_master_programme_links[x:length(ph_master_programme_links)]

process_degrees(.url = y, store = phdegree_store)

ragnar_store_build_index(phdegree_store)