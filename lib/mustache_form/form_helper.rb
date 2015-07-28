require 'mustache'
#
module MustacheForm
  module FormHelper

  def custom_form_tag(url: nil, html: nil)
    # When the Mustache value is a callable object, such as a function or lambda, the
    # object will be invoked and passed the block of text..
    # - hence we then yield to the standard ruby form_for to build our form and then
    # - have Mustache render each key value pair
    lambda do |text|
      #puts "\n\nTemplate-Text: #{text}\n\n"
      form_tag(url: url, html: html) do |f|
        obj = FormedMustache.new(yield(f))
        #puts "\n\nObject to render: #{obj.inspect}\n\n"
        Mustache.render(text, obj).html_safe
      end
    end
  end

  def custom_form_for(object, url: nil, html: nil)
    # When the Mustache value is a callable object, such as a function or lambda, the
    # object will be invoked and passed the block of text..
    # - hence we then yield to the standard ruby form_for to build our form and then
    # - have Mustache render each key value pair
    lambda do |text|
      #puts "\n\nTemplate-Text: #{text}\n\n"
      form_for(object, url: url, html: html) do |f|
        obj = FormedMustache.new(yield(f))
        #puts "\n\nObject to render: #{obj.inspect}\n\n"
        Mustache.render(text, obj).html_safe
      end
    end
  end

  def custom_simple_form_tag(url: nil, html: nil)
    lambda do |text|
      simple_form_tag(url: url, html: html) do |f|
        obj = FormedMustache.new(yield(f))
        Mustache.render(text, obj).html_safe
      end
    end
  end

  def custom_simple_form_for(object, url: nil, html: nil)
    lambda do |text|
      simple_form_for(object, url: url, html: html) do |f|
        obj = FormedMustache.new(yield(f))
        Mustache.render(text, obj).html_safe
      end
    end
  end

end

class FormedMustache < Mustache

  def initialize(data)
    data.each_pair do |key, value|
      #puts "\n\nkey: #{key}, value: #{value} \n\n"
      FormedMustache.send(:define_method, key, proc{value})
    end
  end

  def escapeHTML(str)
    str
  end

end
end
