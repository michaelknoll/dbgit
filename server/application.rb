##
# Class implements the entry point for the Database Repository server.
#
# @author Michael Lihs <mimi@kaktusteam.de>
#
class DatabaseRepositoryServer < Sinatra::Base

  @@my_app = {}

  # Setup logging (see http://spin.atomicobject.com/2013/11/12/production-logging-sinatra/)
  ::Logger.class_eval { alias :write :'<<' }
  log_formatter = proc do |severity, datetime, progname, msg|
    "[#{datetime}] #{severity} #{msg}\n"
  end

  base_path = ::File.dirname(::File.expand_path(__FILE__))

  access_log = ::File.join(base_path, 'log', 'access_log')
  access_logger = ::Logger.new(access_log, 10, 1024000)
  access_logger.formatter = log_formatter

  api_log = ::File.join(base_path, 'log', 'api_log')
  api_logger = ::Logger.new(api_log, 10, 1024000)
  api_logger.formatter = log_formatter

  error_logger = ::File.new(::File.join(base_path, 'log', 'error_log'), "a+")
  error_logger.sync = true

  before {
    env["rack.errors"] =  error_logger
    env["rack.logger"] =  api_logger
  }


  def self.new(*)
    self < DatabaseRepositoryServer ? super : Rack::URLMap.new(@@my_app)
  end



  def self.map(url)
    @@my_app[url] = self
  end



  ##
  # Set up the application for *all* contexts.
  # Specific settings are overridden for other contexts!
  #
  configure do
    register Sinatra::ConfigFile
    register Sinatra::DatabaseRepository

    enable :logging
    use ::Rack::CommonLogger, access_logger

    set :allow_credentials, true
    set :allow_methods, [:get, :post]
    set :max_age, 60

    # Get context configuration
    # See http://www.sinatrarb.com/contrib/config_file.html for usage
    config_file 'config/config_production.yaml'

    set :storage_config, settings.storage
  end



  ##
  # Set up the application for *development* context
  #
  configure :development do
    # Configure reloader to reload controllers and lib functions
    register Sinatra::Reloader
    also_reload ::File.join(base_path, 'controllers', '*.rb')
    also_reload ::File.join(base_path, 'lib', '*.rb')

    config_file 'config/config_development.yaml'
  end



  ##
  # The ServerController handles the methods provided
  # by the Database Repository server
  #
  class ServerController < DatabaseRepositoryServer
    map '/'
  end

end
