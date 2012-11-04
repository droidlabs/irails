require 'capistrano/ext/multistage'
require 'bundler/capistrano'

set :stages, %w(staging production)
set :default_stage, "staging"
set :deploy_via, :remote_cache
set :keep_releases, 5
set :scm, :git
set(:rake_cmd) {"#{bundle_cmd rescue 'bundle'} exec rake RAILS_ENV=#{rails_env}"}

before  'deploy:setup', 'db:configure'
after   'deploy:setup', 'deploy:first'

before  'deploy:assets:precompile', 'db:create_symlink'
after   'deploy:create_symlink', 'deploy:cleanup'
after   'deploy:migrate', 'db:migrate_data'

# local precompile assets
before  'deploy:finalize_update', 'deploy:assets:symlink'
after   'deploy:update_code', 'deploy:assets:precompile'

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, roles: :app, except: { no_release: true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  task :first do
    deploy.update
    db.setup
  end
end

namespace :db do
  desc "Create database yaml in shared path"
  task :configure do
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

  desc "Make symlink for database.yml"
  task :create_symlink do
    run "ln -nfs #{shared_path}/config/database.yml #{latest_release}/config/database.yml"
  end

  desc "Setup DB data"
  task :setup do
    run "cd #{latest_release} && RAILS_ENV=#{rails_env} rake db:setup"
  end

  task :migrate_data do
    run "cd #{release_path} && RAILS_ENV=#{rails_env} rake data:migrate"
  end
end