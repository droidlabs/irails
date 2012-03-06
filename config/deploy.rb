require 'capistrano/ext/multistage'
require 'bundler/capistrano'

set :stages, %w(staging production)
set :default_stage, "staging"
set :keep_releases, 5
set :scm, :git

before  'deploy:setup', 'db:configure'
before  'deploy:assets:precompile', 'db:symlink'
after   'deploy:symlink', 'deploy:cleanup'

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, roles: :app, except: { no_release: true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
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
  end

  desc "Make symlink for database.yml"
  task :symlink do
    run "ln -nfs #{shared_path}/config/database.yml #{latest_release}/config/database.yml"
  end
end