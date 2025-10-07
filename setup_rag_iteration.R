# Iterate on RAG ingest --------------------------------------------------------

process_degrees(.url = ph_master_programme_links[81:333], store = phdegree_store)

### Index store ----
ragnar_store_build_index(phdegree_store)
