require "resque/tasks"

task "resque:setup" => :environment do
  if configatron.background_jobs.namespace
    Resque.redis.namespace = "resque:#{configatron.background_jobs.namespace}"
  end
  Resque.before_fork = Proc.new { ActiveRecord::Base.establish_connection }
end