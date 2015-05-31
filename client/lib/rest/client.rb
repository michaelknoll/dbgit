require 'rest-client'
require 'JSON'

module DatabaseRepository

  class Client

    def initialize(server_url)
      @server_url = server_url
    end

    def list(db_name)
      JSON.parse(get("list/#{db_name}"))
    end

    def push(db_name, tag, path_and_filename)
      JSON.parse(RestClient.post "#{@server_url}/#{db_name}/#{tag}", :file => File.new(path_and_filename, 'rb'))
    end

    def delete(db_name, tag)
      JSON.parse(RestClient.delete "#{@server_url}/#{db_name}/#{tag}")
    end

    def pull(db_name, tag)
      response = RestClient.get "#{@server_url}/#{db_name}/#{tag}"
      snapshot = File.new("/tmp/#{db_name}_#{tag}", 'w')
      snapshot.puts response
      snapshot.close
      snapshot
    end

    def get(resource)
      resource = RestClient::Resource.new "#{@server_url}/#{resource}"
      resource.get
    end

  end

end