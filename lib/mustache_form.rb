require "mustache_form/version"
#
require File.dirname(__FILE__) + '/mustache_form/form_helper'
require File.dirname(__FILE__) + '/mustache_form/railtie' if defined? ::Rails::Railtie
#
module MustacheForm
  class Config
    attr_accessor :simple_form_enabled
  end

  def self.config
    @@config ||= Config.new
  end

  def self.configure
    yield self.config
  end
end
