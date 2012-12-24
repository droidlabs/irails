class Workers::Sample < Workers::Base
  @queue = :worker
  # Start worker with command: Workers::Sample.perform_async('test')
  def perform!(text)
    logger.info "Sample Job: #{text}"
  end
end