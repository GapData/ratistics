$:.push File.join(File.dirname(__FILE__), 'lib')
$:.push File.join(File.dirname(__FILE__), 'tasks/support')

require 'rubygems'
require 'bundler/gem_tasks'
require 'rspec'
require 'rspec/core/rake_task'
require 'yard'

require 'ratistics'

Bundler::GemHelper.install_tasks

RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = '--color'
end

RSpec::Core::RakeTask.new(:jruby_spec) do |t|
  t.rspec_opts = '--color --tag ~@ar'
end

YARD::Rake::YardocTask.new do |t|
end

unless RbConfig::CONFIG['ruby_install_name']=~ /^jruby$/i
  require 'standalone_migrations'
  StandaloneMigrations::Tasks.load_tasks
end

$:.unshift 'tasks'
Dir.glob('tasks/**/*.rake').each do|rakefile|
  load rakefile
end

task :default => [:spec]
