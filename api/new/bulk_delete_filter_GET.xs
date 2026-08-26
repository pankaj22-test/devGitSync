// DEV-7629 repro: bulk delete whose where clause pipes now through timestamp_add_seconds
query bulk_delete_filter verb=GET {
  api_group = "new"

  input {
  }

  stack {
    !db.query repro_table {
      where = $db.repro_table.updated_at <= (now|timestamp_add_seconds:86400)
      return = {type: "list"}
    } as $query
  
    db.bulk.delete repro_table {
      where = $db.repro_table.updated_at <= (now|timestamp_add_seconds:86400)
    } as $delete
  }

  response = {delete: $delete, !query: $query}
}