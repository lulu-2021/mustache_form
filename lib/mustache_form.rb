require "mustache_form/version"
#
require File.dirname(__FILE__) + '/mustache_form/form_helper'
require File.dirname(__FILE__) + '/mustache_form/railtie' if defined? ::Rails::Railtie
#
module MustacheForm

  @@configured = false

  def self.configured?
    @@configured
  end

  # - the configuration option to turn on simple_form support or off (in the initializer)
  mattr_accessor :simple_form_enabled
  @@error_method = false

  # Default way to setup MustacheForm. Run rails generate mustache_form:install
  # to create a fresh initializer with all configuration values.
  def self.setup
    @@configured = true
    yield self if block_given?
  end
end
