require 'mustache'
#
# When the Mustache variable is a callable object, such as a function or lambda, the
# object will be invoked and passed the block of text. hence we then yield to the
# standard ruby form_for to build our form and then have Mustache render each key value pair
module MustacheForm
  module FormHelper

    # The basic form_tag just wraps the rails form_tag helper and then yields to
    # the view method that handles the form inputs
    #
    #-form_tag(url_for_options = {}, options = {}, &block)
    #
    def mustache_form_tag(url_for_options: {}, html_options: {})
      formable = :form_tag
      lambda do |text|
        send(formable, url_for_options, html_options) do |f|
          obj = FormedMustache.new(yield(f))
          Mustache.render(text, obj).html_safe
        end
      end
    end

    # The form_for version in the basic form wraps the rails form_for helper and
    # then yields to the method that handles the form inputs. It also handles the
    # the optional use of the simple_form form helper. Since the method signature
    # is identical it just needs to call the correct method name
    #
    #-form_for(record, options = {}, &block)
    #-simple_form_for(record, options = {}, &block)
    #
    def mustache_form_for(object, url_for_options: {}, html_options: {}, use_rails_form_helper: false)
      MustacheForm.simple_form_enabled == true ? formable = :simple_form_for : formable = :form_for
      formable = :form_for if use_rails_form_helper
      lambda do |text|
        options = {
          url: url_for_options, html: html_options
        }
        send(formable, object, options) do |f|
          obj = FormedMustache.new(yield(f))
          Mustache.render(text, obj).html_safe
        end
      end
    end

    def self.included(base)
      base.class_eval do
        alias_method :custom_form_tag, :mustache_form_tag
        alias_method :custom_form_for, :mustache_form_for
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
