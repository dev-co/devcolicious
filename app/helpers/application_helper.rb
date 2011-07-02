module ApplicationHelper

  def error_messages_for( object )
    result = ''
    if object.respond_to? :errors and object.errors.any?
      title  = "#{ pluralize( object.errors.count, 'error' ) } prohibited this #{ object.class.name.downcase } from being saved:"
      result << '<div class="errors_explanation">\n'
      result << "<h2>#{ title }</h2>\n"
      result << '<ul>\n'
      object.errors.full_messages.each do |message|
        result << "<li>#{ message }</li>\n"
      end
      result << '</ul>\n'
      result << '</div>\n'
    end
    result.html_safe
  end

end
