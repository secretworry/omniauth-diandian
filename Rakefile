# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "omniauth-diandian"
  gem.homepage = "http://github.com/secretworry/omniauth-diandian"
  gem.license = "MIT"
  gem.summary = %Q{OmniAuth Strategy for diandian}
  gem.description = %Q{And OmniAuth Strategy for diandian using OAuth2}
  gem.email = "dusiyh@gmail.com"
  gem.authors = ["secretworry"]
  # dependencies defined in Gemfile
  gem.add_dependency 'diandian-oauth', "> 0"
  gem.add_dependency 'omniauth', '~> 1.1.0'
  gem.add_dependency 'omniauth-oauth2', '~> 1.1.0'
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

=begin
require 'rcov/rcovtask'
Rcov::RcovTask.new do |test|
  test.libs << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
  test.rcov_opts << '--exclude "gems/*"'
end
=end

task :default => :test

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "omniauth-diandian #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
