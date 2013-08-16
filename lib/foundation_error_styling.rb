require "foundation_error_styling/version"

module FoundationErrorStyling
  class FoundationErrorStyling < Rails::Railtie
    # assign the proc to adjust the form field error classes
    initializer "foundation_error_styling.apply_error_classes" do
      ActionView::Base.field_error_proc = Proc.new do |html_tag, instance_tag|
        if html_tag =~ /<(input|textarea|select|div)[^>]+class=/
          class_attribute = html_tag =~ /class=['"]/
          html_tag.insert(class_attribute + 7, "error ")
          html_tag = html_tag + "<small class='error'>".html_safe+instance_tag.error_message.first+"</small>".html_safe
        elsif html_tag =~ /<label/
          first_whitespace = html_tag =~ /\s/
          html_tag[first_whitespace] = " class='error' "
        elsif html_tag =~ /<(input|textarea|select|label|)/
          first_whitespace = html_tag =~ /\s/
          html_tag[first_whitespace] = " class='error' "
          html_tag = html_tag + "<small class='error'>".html_safe+instance_tag.error_message.first+"</small>".html_safe
        end
        html_tag
      end
    end
  end
end
