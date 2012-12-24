if defined?(Resque)
  require 'resque/server'

  resque_yml = File.expand_path('../../resque.yml', __FILE__)
  if File.exist?(resque_yml)
    Resque.redis = YAML.load_file(resque_yml)["redis_uri"]
  end
  if configatron.background_jobs.namespace
    Resque.redis.namespace = "resque:#{configatron.background_jobs.namespace}"
  end

  Resque::Server.use Rack::Auth::Basic do |username, password|
    !configatron.background_jobs.auth || (
      username == configatron.background_jobs.username &&
      password == configatron.background_jobs.password
    )
  end
end
if defined?(Sidekiq)
  # Sidekiq.configure_server do |config|
  #  config.redis = {url: url, namespace: namespace}
  # end
  # Sidekiq.configure_client do |config|
  #   config.redis = {url: url, namespace: namespace}
  # end
end
