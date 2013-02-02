require 'capistrano/ext/multistage'
require 'bundler/capistrano'
# require 'capistrano-rbenv'

set :stages, %w(staging production)
set :default_stage, "staging"
set :deploy_via, :remote_cache
set :keep_releases, 5
set :scm, :git

before  'deploy:setup', 'db:create_config'
after   'deploy:setup', 'deploy:first'

after   'deploy:update_code', 'db:create_symlink'
after   'deploy:create_symlink', 'deploy:cleanup'
after   'deploy:migrate', 'db:migrate_data'

# local precompile assets
before  'deploy:finalize_update', 'deploy:assets:symlink'
after   'deploy:update_code', 'deploy:assets:precompile'

# resque
# after   'deploy:restart', 'resque:restart'
# after   'deploy:restart', 'resque_scheduler:restart'