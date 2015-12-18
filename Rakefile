require "bundler/gem_tasks"
require 'rspec/core/rake_task'
require 'rdoc/task'

RSpec::Core::RakeTask.new

Rake::RDocTask.new do |rd|
    rd.rdoc_files.include("lib/**/*.rb")
end

task :default => :spec
