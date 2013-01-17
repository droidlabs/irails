set(:server_type, "passenger")

set(:thin_command) { "#{bundle_cmd} exec thin" }
set(:thin_config_file) { "#{current_path}/thin.yml" }
set(:thin_config) { "-C #{thin_config_file}" }

namespace :deploy do
  task :start do
    send(server_type.to_sym).start
  end
  task :stop do
    send(server_type.to_sym).stop
  end
  task :restart, roles: :app, except: { no_release: true } do
    send(server_type.to_sym).restart
  end
  task :first do
    set :deploy_via, :copy
    deploy.update
    db.setup
  end
end

namespace :passenger do
  task :start do ; end
  task :stop do ; end
  task :restart, roles: :app, except: { no_release: true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

namespace :thin do
  desc "Make symlink for thin.yml"
  task :create_symlink do
    run "ln -nfs #{shared_path}/config/thin.yml #{latest_release}/thin.yml"
  end

  task :start do
    run "cd #{current_path} && #{thin_command} #{thin_config} start"
  end

  task :stop do
    run "cd #{current_path} && #{thin_command} #{thin_config} stop"
  end

  task :restart do
    run "cd #{current_path} && #{thin_command} #{thin_config} -O restart"
  end
end