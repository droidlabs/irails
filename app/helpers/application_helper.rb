module ApplicationHelper
  def conditional_html(&block)
    lang = I18n.locale
    html = <<-"HTML".gsub( /^\s+/, '' )
      <!--[if lt IE 7 ]>    <html lang="#{lang}" class="ie ie6"> <![endif]-->
      <!--[if IE 7 ]>       <html lang="#{lang}" class="ie ie7"> <![endif]-->
      <!--[if IE 8 ]>       <html lang="#{lang}" class="ie ie8"> <![endif]-->
      <!--[if IE 9 ]>       <html lang="#{lang}" class="ie ie9"> <![endif]-->
      <!--[if (gte IE 9)|!(IE)]><!--> <html lang="#{lang}"> <!--<![endif]-->
    HTML
    html += capture( &block ) << "\n</html>".html_safe if block_given?
    html.html_safe
  end

  def navigation_link_to(title, url, options = {}, &block)
    if current_page?(url)
      css_class = options[:class]
      options[:class] = css_class.present? ? "#{css_class} active" : 'active'
    end
    link_to(title, url, options, &block)
  end
end
