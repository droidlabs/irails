def assets_changed?
  from = source.next_revision(current_revision)
  asset_dirs = "vendor/assets/ app/assets/"
  capture("cd #{latest_release} && #{source.local.log(from)} #{asset_dirs} | wc -l").to_i > 0
end

namespace :deploy do
  namespace :assets do
    task :precompile, roles: :web do
      is_first_deploy = !remote_file_exists?(File.join(current_path, "REVISION"))
      if is_first_deploy || assets_changed?
        precompile!
      else
        logger.info "Skipping asset precompilation because there were no asset changes"
      end
    end

    task :symlink, roles: :web do
      run ("rm -rf #{latest_release}/public/assets &&
            mkdir -p #{latest_release}/public &&
            mkdir -p #{latest_release}/public/stylesheets &&
            mkdir -p #{latest_release}/public/javascripts &&
            mkdir -p #{latest_release}/public/images &&
            mkdir -p #{shared_path}/assets &&
            ln -s #{shared_path}/assets #{latest_release}/public/assets")
    end

    task :precompile!, roles: :web do
      rsync_path = "#{user}@#{dns_name}:#{shared_path}"
      rsync_options = "--recursive --times --rsh=ssh --compress --human-readable --progress -e 'ssh -p #{port}'"

      run_locally("rm -rf public/assets/")
      run_locally("rake RAILS_ENV=#{rails_env} assets:precompile")
      run_locally("rsync #{rsync_options} public/assets #{rsync_path}")
      run_locally("rm -rf public/assets/")
    end

    task :precompile_and_symlink, roles: :web do
      precompile!
      symlink
    end
  end
end