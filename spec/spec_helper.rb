#require 'coveralls'
#Coveralls.wear!
#
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib/mustache_form'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
#
ENV["RAILS_ENV"] ||= 'test'
#
require 'rspec'
require 'rspec/given'
require 'rack'
#
require 'active_support'
require 'active_support/core_ext'
require 'mustache_form'
#
# - this loads the actual form helper
#require 'mustache_form/load_form_helper'
# - then run the load process that is normally handled by rails!
#LoadFormHelper.load
