require 'capistrano/ext/multistage'
require 'bundler/capistrano'
# require 'capistrano-rbenv'

set :stages, %w(staging production)
set :default_stage, "staging"
set :deploy_via, :remote_cache
set :keep_releases, 5
set :scm, :git
set(:rake_cmd) {"#{bundle_cmd rescue 'bundle'} exec rake RAILS_ENV=#{rails_env}"}

before  'deploy:setup', 'db:create_config'
after   'deploy:setup', 'deploy:first'

before  'deploy:assets:precompile', 'db:create_symlink'
after   'deploy:create_symlink', 'deploy:cleanup'
after   'deploy:migrate', 'db:migrate_data'

# local precompile assets
before  'deploy:finalize_update', 'deploy:assets:symlink'
after   'deploy:update_code', 'deploy:assets:precompile'

# resque
# after   'deploy:restart', 'resque:restart'
# after   'deploy:restart', 'resque_scheduler:restart'

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