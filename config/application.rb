require 'grape'
require 'json'
require 'rest-client'
require 'yaml'
require 'erb'
require 'active_record'

require_relative '../app/api/controller.rb'
require_relative '../app/models/access_token'
require_relative '../app/models/auth_param'
require_relative '../app/helpers/vk_sender'
require_relative '../app/helpers/analiser/vk_wall_analiser'
require_relative '../app/helpers/authorize/vk_authorize'

# Sets up database configuration
db = URI.parse(ENV['DATABASE_URL'] || 'http://0.0.0.0')
if db.scheme == 'postgres' # Heroku environment
  ActiveRecord::Base.establish_connection(
      :adapter  => db.scheme == 'postgres' ? 'em_postgresql' : db.scheme,
      :host     => db.host,
      :username => db.user,
      :password => db.password,
      :database => db.path[1..-1],
      :encoding => 'utf8'
  )
else # local environment
  # environment = ENV['DATABASE_URL'] ? 'test' : 'development'
  environment = 'test'
  db = YAML.load(ERB.new(File.read('config/database.yml')).result)[environment]
  ActiveRecord::Base.establish_connection(db)

  # ActiveRecord::Base.connection.create_database(db['database'])
  ActiveRecord::Migrator.migrate('db/migrate/')

end