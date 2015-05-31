class DatabaseRepositoryServer

  ##
  # Class implements the controller for all database repository server methods.
  #
  # @author Michael Lihs <mimi@kaktusteam.de>
  #
  class ServerController

    # TODO figure out, why "register" does not work here!
    include Sinatra::DatabaseRepository::DatabaseRepositoryServer



    before do
      storage_factory = DatabaseRepository::Storage::StorageFactory.new
      @storage = storage_factory.build_for_configuration(settings.storage)
    end



    # TODO add graceful error handling, e.g. by returning an appropriate HTTP status code

    # Implements a ping action
    get '/ping' do
      { :response => 'pong' }.to_json
    end



    # Returns all database snapshots for a given database name
    get '/list/:db_name' do
      @storage.list(params['db_name']).to_json
    end



    # Returns the database snapshot for a given database name and tag name
    get '/:db_name/:tag' do
      snapshot = @storage.get(params['db_name'], params['tag'])
      send_file snapshot.path, :filename => "#{params['db_name']}_#{params['tag']}", :type => 'Application/octet-stream'
    end



    # Persists a new database snapshot for a given database name and tag
    post '/:db_name/:tag' do
      @storage.persist(params['file'][:tempfile], params['db_name'], params['tag'])
      { :url => url_for(params['db_name'], params['tag']) }.to_json
    end



    # Deletes a snapshot for a given database name and a given tag
    delete '/:db_name/:tag' do
      @storage.delete(params['db_name'], params['tag'])
      { :deleted => true }.to_json
    end

  end

end
