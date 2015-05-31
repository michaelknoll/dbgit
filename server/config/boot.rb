app_dir = File.expand_path("../", File.dirname(__FILE__))

# Make sure to load the helpers class before the application, since the Sinatra Extension implemented in the helpers file
# needs to be registered in the application and therefore needs to be loaded before the application!
require "#{app_dir}/lib/helpers"
require "#{app_dir}/application"

controller_files = File.join(app_dir, %w(controllers ** *_controller.rb))
server_lib_files = File.join(app_dir, %w(lib ** *))
global_lib_files = File.join("#{app_dir}/..", %w(lib ** *))

files = [controller_files, server_lib_files, global_lib_files]

Dir.glob(files).each do |lf|
  unless File.directory?(lf)
    puts "Loading file '#{lf}'"
    require lf
  end
end
