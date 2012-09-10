class Services::Result
  def initialize(service_name)
    @service_name = service_name
    @status = ''
    @errors = []
  end

  def with_status(status)
    @status = status
    self
  end
  alias_method :and_status, :with_status

  def with_errors(errors)
    @errors = errors
    self
  end
  alias_method :and_errors, :with_errors

  def success?
    @errors.blank?
  end

  def failed?
    !success?
  end

  def message
    I18n.t("services.results.#{@service_name}.#{@status}")
  end

  def errors
    @errors.map do |error|
      normalize_error(error)
    end
  end

  def normalize_error(error)
    if error.is_a?(Symbol)
      I18n.t("services.errors.#{@service_name}.#{error}")
    else
      error
    end
  end

  def to_json
    {message: message, errors: errors, status: status}.to_json
  end
end