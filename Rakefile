#!/usr/bin/env rake
begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end
begin
  require 'rdoc/task'
rescue LoadError
  require 'rdoc/rdoc'
  require 'rake/rdoctask'
  RDoc::Task = Rake::RDocTask
end

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'FactoryGirlRails::RemoteApi'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

APP_RAKEFILE = File.expand_path("../spec/dummy/Rakefile", __FILE__)
load 'rails/tasks/engine.rake'

# Load all tasks
Dir[File.join(File.dirname(__FILE__), 'tasks/**/*.rake')].each {|f| load f }

Bundler::GemHelper.install_tasks

begin
  require 'rspec/core'
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec => ['app:db:migrate', 'app:db:test:prepare'])
rescue LoadError
  desc 'spec rake task not available (rspec not installed)'
  task :spec do
    abort 'Spec rake task is not available. Be sure to install rspec as gem.'
  end
end

task default: :spec
