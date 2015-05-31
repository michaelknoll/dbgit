#\ -p 4567

# Load gems and requires
require 'rubygems'
require 'bundler'
require 'json'
require 'sinatra/base'
require 'sinatra/config_file'
require 'sinatra/reloader'
require 'webrick'
require 'webrick/https'
require 'openssl'
require 'logger'
require 'fileutils'

DOCUMENT_ROOT = File.expand_path(File.dirname(__FILE__))

# Create the log folder
FileUtils::mkdir_p "#{DOCUMENT_ROOT}/log"

Bundler.require
require './config/boot'

# Redirecting log output to a logfile - see https://github.com/sinatra/sinatra/issues/484
log = File.new("#{DOCUMENT_ROOT}/log/server_log", "a+")
$stdout.reopen(log)
$stderr.reopen(log)
$stderr.sync = true
$stdout.sync = true

webrick_options = {
  :Port               => 4567,
  :AccessLog          => [],
  :Logger             => WEBrick::Log::new($stderr, WEBrick::Log::DEBUG),
  :DocumentRoot       => DOCUMENT_ROOT,
  :app                => DatabaseRepositoryServer
}
Rack::Server.start webrick_options

