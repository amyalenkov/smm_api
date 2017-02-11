require 'rspec/core/rake_task'

require_relative 'config/application.rb'

namespace :db do

  db_config = YAML.load(ERB.new(File.read('config/database.yml')).result)

  desc 'Create the database'
  task :create do
    ActiveRecord::Base.configurations = db_config

    # drop and create need to be performed with a connection to the 'smm_development' (system) database
    ActiveRecord::Base.establish_connection db_config['development'].merge('database' => 'smm_development',
                                                                           'schema_search_path' => 'public')
    ActiveRecord::Base.connection.create_database(db_config['development']['database'])
    puts 'Database created.'
  end

  desc 'Migrate the database'
  task :migrate do
    ActiveRecord::Base.configurations = db_config

    # drop and create need to be performed with a connection to the 'smm_development' (system) database
    ActiveRecord::Base.establish_connection db_config['development'].merge('database' => 'smm_development',
                                                                           'schema_search_path' => 'public')
    ActiveRecord::Migrator.migrate('db/migrate/')
    Rake::Task['db:schema'].invoke
    puts 'Database migrated.'
  end

  desc 'Drop the database'
  task :drop do

    ActiveRecord::Base.configurations = db_config

    # drop and create need to be performed with a connection to the 'smm_development' (system) database
    ActiveRecord::Base.establish_connection db_config['development'].merge('database' => 'smm_development',
                                                                           'schema_search_path' => 'public')

    ActiveRecord::Base.connection.drop_database(db_config['development']['database'])
    puts 'Database deleted.'
  end

  desc 'Reset the database'
  task :reset => [:drop, :create, :migrate]

  desc 'Create a db/schema.rb file that is portable against any DB supported by AR'
  task :schema do
    ActiveRecord::Base.configurations = db_config

    # drop and create need to be performed with a connection to the 'smm_development' (system) database
    ActiveRecord::Base.establish_connection db_config['development'].merge('database' => 'smm_development',
                                                                           'schema_search_path' => 'public')

    require 'active_record/schema_dumper'
    filename = 'db/schema.rb'
    File.open(filename, 'w:utf-8') do |file|
      ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, file)
    end
  end


end
