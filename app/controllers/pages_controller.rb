class PagesController < ApplicationController
  layout 'pages'

  rescue_from ActionView::MissingTemplate do |exception|
    if exception.message =~ %r{Missing template}
      raise ActionController::RoutingError, "No such page: #{params[:id]}"
    else
      raise exception
    end
  end

  def show
    render "pages/#{current_page}"
  end

  protected
  def current_page
    path = Pathname.new "/#{params[:id]}"
    path.cleanpath.to_s[1..-1]
  end
end