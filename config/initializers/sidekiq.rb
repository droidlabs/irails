require 'workers/base'
if defined?(Sidekiq)
  # Sidekiq.configure_server do |config|
  #  config.redis = {url: url, namespace: namespace}
  # end
  # Sidekiq.configure_client do |config|
  #   config.redis = {url: url, namespace: namespace}
  # end
end