#!/usr/bin/env rake

require 'appraisal'

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
  rdoc.title    = 'FactoryGirl::RemoteApi'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

begin
  require 'rspec/core'
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(spec: %w[app:db:migrate app:db:test:prepare])
rescue LoadError
  desc 'spec rake task not available (rspec not installed)'
  task :spec do
    abort 'Spec rake task is not available. Be sure to install rspec as gem.'
  end
end

# Find the right dummy Rakefile to load. If in appraisal, use that version of dummy Rails, else default to 3.2.
rails_minor_version = if ENV['BUNDLE_GEMFILE'] =~ /gemfiles/
                        ENV['BUNDLE_GEMFILE'].split('/').last.scan(/(\d).(\d)/).join
                      else
                        '32'
                      end
APP_RAKEFILE = File.expand_path("../spec/dummy_#{rails_minor_version}/Rakefile", __FILE__)

# Ensure the dummy app is in the test environment
ENV['RAILS_ENV'] ||= 'test'

# Stop Rails from resetting the BUNDLE_GEMFILE env variable on load.
old_bundle_gemfile = ENV['BUNDLE_GEMFILE']
load 'rails/tasks/engine.rake'
ENV['BUNDLE_GEMFILE'] = old_bundle_gemfile

# Load all tasks
Dir[File.join(File.dirname(__FILE__), 'tasks/**/*.rake')].each {|f| load f }

Bundler::GemHelper.install_tasks

task default: :spec
