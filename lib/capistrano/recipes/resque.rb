set(:resque_num_of_queues, 1)
set(:resque_polling_interval, 5)
set(:resque_queue_name, "*")
set(:resque_verbosity, 1)

def remote_process_exists?(pid_file)
  capture("ps -p $(cat #{pid_file}) ; true").strip.split("\n").size == 2
end

namespace :resque do
  desc "Start Resque workers"
  task :start do
    puts "Starting #{resque_num_of_queues} worker(s) with QUEUE: #{resque_queue_name}"
    resque_num_of_queues.times do |i|
      pid = "#{current_path}/tmp/pids/resque_worker_#{i}.pid"
      run "cd #{current_path} && RAILS_ENV=#{rails_env} QUEUE=#{resque_queue_name} \
          INTERVAL=#{resque_polling_interval} PIDFILE=#{pid} BACKGROUND=yes \
          LOGFILE=#{current_path}/log/resque-worker#{i}.log VVERBOSE=#{resque_verbosity}  \
          #{rake_cmd} environment resque:work"
    end
  end

  desc "Quit running Resque workers"
  task :stop do
    resque_num_of_queues.times do |i|
      pid = "#{current_path}/tmp/pids/resque_worker_#{i}.pid"
      if remote_file_exists?(pid)
        if remote_process_exists?(pid)
          logger.important("Stopping...", "Resque Worker #{i}")
          run "#{try_sudo} kill `cat #{pid}`"
        else
          run "rm #{pid}"
          logger.important("Resque Worker #{i} is not running.", "Resque")
        end
      else
        logger.important("No PIDs found. Check if Resque is running.", "Resque")
      end
    end
  end

  desc "Restart Resque"
  task :restart do
    stop
    start
  end
end