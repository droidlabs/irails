log "truncate database" do
  ActiveRecord::Base.connection.tables.each do |table|
    next if table == "schema_migrations"
    ActiveRecord::Base.connection.execute("TRUNCATE #{table}")
  end
end