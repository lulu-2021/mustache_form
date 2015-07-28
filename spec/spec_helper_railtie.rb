#require 'coveralls'
#Coveralls.wear!
#
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
#
ENV["RAILS_ENV"] ||= 'test'
#
require 'rspec'
require 'rspec/given'
require 'rack'
#
require 'rails'
#
