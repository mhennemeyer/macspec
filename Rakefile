require 'rubygems'
require 'rake'
require 'lib/mac_spec/version.rb'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.version = MacSpec::VERSION
    gem.name = "MacSpec"
    gem.summary = %Q{MacSpec is a feature minimal RSpec clone that is specifically built to work with MacRuby.}
    gem.description = %Q{MacSpec is a feature minimal RSpec clone that is specifically built to work with MacRuby.}
    gem.email = "mhennemeyer@me.com"
    gem.homepage = "http://github.com/mhennemeyer/MacSpec"
    gem.authors = ["Matthias Hennemeyer"]
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'spec'
  test.pattern = 'spec/**/*_spec.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'spec/**/*_spec.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install rcov"
  end
end

task :test => :check_dependencies

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "MacSpec #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
