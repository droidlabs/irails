set :db_username, "DB_USER_NAME"
set(:db_name_development) { application + "_development" }
set(:db_name_test)        { application + "_test" }
set(:db_name_production)  { application + "_production" }
set(:db_name_staging)     { application + "_staging" }

namespace :db do
  desc "Create database yaml in shared path"
  task :create_config do
    if !remote_file_exists?("#{shared_path}/config/database.yml")
      set :db_password do
        Capistrano::CLI.password_prompt "Database Password: "
      end

      db_config = <<-EOF
default: &default
  adapter: mysql2
  encoding: utf8
  username: #{db_username}
  password: #{db_password}

development:
  database: #{db_name_development}
  <<: *default

test:
  database: #{db_name_test}
  <<: *default

staging:
  database: #{db_name_staging}
  <<: *default

production:
  database: #{db_name_production}
  <<: *default
      EOF

      run "mkdir -p #{shared_path}/config"
      put db_config, "#{shared_path}/config/database.yml"
      run "mysql --user=#{db_username} --password=#{db_password} -e \"CREATE DATABASE IF NOT EXISTS #{db_name_staging}\""
      run "mysql --user=#{db_username} --password=#{db_password} -e \"CREATE DATABASE IF NOT EXISTS #{db_name_production}\""
    end
  end

  desc "Make symlink for database.yml"
  task :create_symlink do
    run "ln -nfs #{shared_path}/config/database.yml #{latest_release}/config/database.yml"
  end

  desc "Setup DB data"
  task :setup do
    run "cd #{latest_release} && #{rake_cmd} db:setup"
  end

  task :migrate_data do
    run "cd #{release_path} && #{rake_cmd} data:migrate"
  end
end