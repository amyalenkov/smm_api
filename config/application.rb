require 'grape'
require 'json'
require 'rest-client'
require 'yaml'
require 'erb'
require 'active_record'
require 'httplog'

require_relative '../app/api/controller.rb'
require_relative '../app/models/access_token'
require_relative '../app/models/auth_param'
require_relative '../app/models/analyse_group'
require_relative '../app/models/user'
require_relative '../app/models/api_key'
require_relative '../app/helpers/vk_sender'
require_relative '../app/helpers/registration'
require_relative '../app/helpers/analiser/vk_wall_analiser'
require_relative '../app/helpers/analiser/vk_group_analyzer'
require_relative '../app/helpers/authorize/vk_authorize'
require_relative '../app/helpers/scheduler'
require_relative '../app/helpers/auth/token_helper'
require_relative '../lib/db_helper/load_data'

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

HttpLog.configure do |config|

  # You can assign a different logger
  config.logger = Logger.new($stdout)

  # I really wouldn't change this...
  config.severity = Logger::Severity::DEBUG

  # Tweak which parts of the HTTP cycle to log...
  config.log_connect   = true
  config.log_request   = true
  config.log_headers   = false
  config.log_data      = true
  config.log_status    = true
  config.log_response  = true
  config.log_benchmark = true

  # ...or log all request as a single line by setting this to `true`
  config.compact_log = false

  # Prettify the output - see below
  config.color = false

  # Limit logging based on URL patterns
  config.url_whitelist_pattern = /.*/
  config.url_blacklist_pattern = nil
end

# Scheduler.set_analyse