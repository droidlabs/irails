log "truncate database" do
  connection = ActiveRecord::Base.connection
  connection.tables.each do |table|
    next if table == "schema_migrations"
    if connection.adapter_name.downcase.to_sym != :sqlite
      connection.execute("TRUNCATE #{table}")
    else
      connection.execute("delete from #{table};")
      connection.execute("delete from sqlite_sequence where name='#{table}';")
    end
  end
end