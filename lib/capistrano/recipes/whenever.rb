namespace :cron do
  desc "Update Cron Job"
  task :update do
    run "cd #{release_path} && RAILS_ENV=#{rails_env} #{bundle_cmd rescue 'bundle'} exec whenever --set environment=#{rails_env} --update-crontab #{application}"
  end
end