module ApplicationHelper
  def restfull_action_name
    case controller.action_name.to_sym
    when :create
      'new'
    when :update
      'edit'
    else
      controller.action_name
    end
  end

  def controller_action_class
    "#{controller.controller_name}-#{restfull_action_name}"
  end

  def controller?(*controllers)
    controllers = controllers.map(&:to_sym)
    controllers.include?(controller.controller_name.to_sym)
  end

  def action?(*actions)
    actions = actions.map(&:to_sym)
    actions.include?(controller.action_name.to_sym)
  end
end