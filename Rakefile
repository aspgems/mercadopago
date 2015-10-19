# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks


namespace :test do

  desc "Test features source"
  Rake::TestTask.new(:features => "test:prepare") do |t|
    t.libs << "test"
    t.pattern = 'test/features/**/*_test.rb'
    t.verbose = true
  end

end

Rake::Task[:test].enhance { Rake::Task["test:features"].invoke }

