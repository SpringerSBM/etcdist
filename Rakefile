require 'bundler/gem_tasks'
require 'rdoc/task'
require 'rubocop/rake_task'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new('spec')

task default: :test

RuboCop::RakeTask.new do |task|
  task.fail_on_error = true
end

RDoc::Task.new do |rdoc|
  rdoc.main = 'README.rdoc'
  rdoc.rdoc_files.include('lib   /*.rb')
end

desc 'Run specs and code checks.'
task :test do
  Rake::Task['spec'].invoke
  Rake::Task['rubocop'].invoke
end
