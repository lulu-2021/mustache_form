require 'mustache'
#
module MustacheForm
  module FormHelper

    SIMPLE_FORM_ENABLED = false #MustacheForm::Config.config.simple_form_enabled || false

    # When the Mustache variable is a callable object, such as a function or lambda, the
    # object will be invoked and passed the block of text. hence we then yield to the
    # standard ruby form_for to build our form and then have Mustache render each key value pair
    def custom_form_tag(url = nil, html = nil, form_helper_method = :form_tag)
      form_helper_method = :simple_form_tag if SIMPLE_FORM_ENABLED
      lambda do |text|
        send(form_helper_method, url: url, html: html) do |f|
          obj = FormedMustache.new(yield(f))
          Mustache.render(text, obj).html_safe
        end
      end
    end

    # When the Mustache variable is a callable object, such as a function or lambda, the
    # object will be invoked and passed the block of text. hence we then yield to the
    # standard ruby form_for to build our form and then have Mustache render each key value pair
    def custom_form_for(object, url = nil, html = nil, form_helper_method = :form_for)
      form_helper_method = :simple_form_for if SIMPLE_FORM_ENABLED
      lambda do |text|
        send(form_helper_method, object, url: url, html: html) do |f|
          obj = FormedMustache.new(yield(f))
          Mustache.render(text, obj).html_safe
        end
      end
    end
  end

  class FormedMustache < Mustache
    def initialize(data)
      data.each_pair do |key, value|
        FormedMustache.send(:define_method, key, proc{value})
      end
    end

    def escapeHTML(str)
      str
    end
  end
end
