require "bundler/gem_tasks"
require 'rspec/core/rake_task'
#
RSpec::Core::RakeTask.new(:spec)
task :default => :spec
#
desc 'Run the test suite for ruby scripts'
namespace :spec do
  task :all do
    Rake::Task["spec"].reenable
    Rake::Task["spec"].invoke
  end
end
