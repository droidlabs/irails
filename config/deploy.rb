require 'capistrano/ext/multistage'
require 'bundler/capistrano'

set :default_environment, {
  'PATH' => "/usr/local/rbenv/shims:/usr/local/rbenv/bin:$PATH"
}

set :stages, %w(staging production)
set :default_stage, "staging"
set :deploy_via, :remote_cache
set :keep_releases, 5
set :scm, :git

after   'deploy:finalize_update',   'deploy:create_symlinks'
before  'deploy:setup', 'db:create_config'
after   'deploy:setup', 'deploy:first'

after   'deploy:finalize_update', 'db:create_symlink'
after   'deploy:create_symlink', 'deploy:cleanup'

#after   'deploy:migrate', 'db:migrate_data'