class Services::Base
  include Services::Logger

  def errors
    @errors ||= []
  end

  def add_error(error)
    errors << error
  end

  def add_error_unless(error, condition)
    add_error(error) unless condition
  end

  def name
    self.class.name.demodulize.underscore
  end

  def normalize_result(status)
    Services::Result.new(name).with_status(status).and_errors(errors)
  end

  def success?
    @errors.blank?
  end
  alias_method :valid?, :success?

  def perform
    validate!
    valid? ? perform! : failure!
  rescue Exception => ex
    Rails.logger.error "#{self.class.name}: #{ex.inspect}"
    failure!
  end

  def test?
    Rails.env.test?
  end

  def validate!
    true
  end

  def perform!
    raise NoMethodError, "Services::Base#perform you should redefine this method"
  end

  def failure!
    normalize_result(:failed)
  end
end
