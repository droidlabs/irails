set(:resque_scheduler_verbosity, 1)

def remote_process_exists?(pid_file)
  capture("ps -p $(cat #{pid_file}) ; true").strip.split("\n").size == 2
end

namespace :resque_scheduler do
  desc "Start Resque scheduler"
  task :start do
    pid = "#{current_path}/tmp/pids/resque_scheduler.pid"
      run "cd #{current_path} && RAILS_ENV=#{rails_env}
          PIDFILE=#{pid} BACKGROUND=yes LOGFILE=#{current_path}/resque_scheduler.log VVERBOSE=#{resque_scheduler_verbosity}  \
          #{rake_cmd} resque:scheduler"
  end

  desc "Stop Resque scheduler"
  task :stop do
    pid = "#{current_path}/tmp/pids/resque_scheduler.pid"
    if remote_file_exists?(pid)
      if remote_process_exists?(pid)
        logger.important("Stopping...", "Resque scheduler")
        run "#{try_sudo} kill `cat #{pid}`"
      else
        run "rm #{pid}"
        logger.important("Resque scheduler is not running.", "Resque")
      end
    else
      logger.important("No PIDs found. Check if Resque scheduler is running.", "Resque")
    end
  end

  desc "Restart Resque"
  task :restart do
    start
    stop
  end
end