set :dns_name, "example.com"

set :application, "APP_NAME"
set :repository,  "GIT_REPO"

role :web, dns_name                          # Your HTTP server, Apache/etc
role :app, dns_name                          # This may be the same as your `Web` server
role :db,  dns_name, :primary => true        # This is where Rails migrations will run

set :deploy_to, "/data/#{application}"

set :rails_env, 'staging'
set :branch, 'master'
set :use_sudo, false

set :user, 'ssh_username'
set :password, 'ssh_password'
set :port, 22

set :db_username, "DB_USER_NAME"
set(:db_name_development) { application + "_development" }
set(:db_name_test)        { application + "_test" }
set(:db_name_production)  { application + "_production" }
set(:db_name_staging)     { application + "_staging" }