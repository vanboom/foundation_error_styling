require "foundation_error_styling/version"
require 'foundation_error_styling/view_helpers'
# TODO: refactor using Nokogiri parsing
#    html_field = Nokogiri::HTML::DocumentFragment.parse(html_tag)
#    html_field.children.add_class 'error'
#    html_field.to_s

module FoundationErrorStyling
  class FoundationErrorStyling < Rails::Railtie
    initializer "foundation_error_styling.view_helpers" do
      ActionView::Base.send :include, ViewHelpers
    end

    # assign the proc to adjust the form field error classes
    initializer "foundation_error_styling.apply_error_classes" do
      ActionView::Base.field_error_proc = Proc.new do |html_tag, instance_tag|
        if html_tag =~ /<(input|textarea|select|div)[^>]+class=/
          class_attribute = html_tag =~ /class=['"]/
          html_tag.insert(class_attribute + 7, "error ")
          html_tag = html_tag + "<small class='error'>" + instance_tag.error_message.first + "</small>"
        elsif html_tag =~ /<label/
          html_field = Nokogiri::HTML::DocumentFragment.parse(html_tag)
          html_field.children.add_class 'error'
          html_tag = html_field.to_s
        elsif html_tag =~ /<(input|textarea|select|label|)/
          html_field = Nokogiri::HTML::DocumentFragment.parse(html_tag)
          html_field.children.add_class 'error'

          html_field.add_child("<small class='error'>" + instance_tag.error_message.first + "</small>")
          html_tag = html_field.to_s
        end
        html_tag.html_safe
      end
    end
  end
end
