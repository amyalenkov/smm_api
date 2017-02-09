require 'rspec/core/rake_task'

require_relative 'config/application.rb'

namespace :db do

  desc 'Creates the database'
  task :create do
    puts 'Creating database...'
    VkDB.setup($db)
  end

  desc 'Seeds the DB'
  task :seed  do
    puts 'Seeding database...'
    group_ids = [1,2,4]
    VkDB.seed(group_ids,$db)
  end

  desc 'Drop the databases'
  task :drop do
    puts 'Deleting databases...'
    rm_f 'vk.db'
  end

end

desc 'Start IRB with application environment loaded'
task :console do
  exec 'irb -r./config/application'
end

desc 'Run the specs'
task :spec do
  RSpec::Core::RakeTask.new(:spec)
end
