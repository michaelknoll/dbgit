module Dbgit
  class Service

    attr_reader :configuration, :rest_client, :database_driver_builder, :storage



    def initialize(configuration)
      @configuration = configuration

      _init_storage
      _init_rest_client
      _init_db_driver_builder
    end



    def create_snapshot(database, tag=nil)
      tag = Time.now if tag == nil
      database_driver = @database_driver_builder.build_driver_for_database(database)
      # TODO the driver should get a configuration for the temporary snapshot location and return a file object here
      tmp_filename = '/tmp/snapshot.sql'
      database_driver.make_snapshot(tmp_filename)
      storage_path = @storage.persist(File.new('/tmp/snapshot.sql'), database, tag)
      File.delete(tmp_filename) if File.exists?(tmp_filename)
      {
        :tag => tag,
        :database_driver => database_driver.to_s,
        :snapshot_location =>  storage_path
      }
    end



    def push_snapshot(database, tag)
      snapshot = @storage.get(database, tag)
      @rest_client.push(database, tag, snapshot.path)
    end



    def pull_snapshot(database, tag)
      snapshot = @rest_client.pull(database, tag)
      @storage.persist(snapshot, database, tag)
    end



    def apply_snapshot(database, snapshot, tag)
      snapshot_file = @storage.get(snapshot, tag)
      database_driver = @database_driver_builder.build_driver_for_database(database)
      database_driver.apply_snapshot(snapshot_file)
    end



    def delete_remote_snapshot(database, tag)
      result = @rest_client.delete(database, tag)
      result.has_key?('deleted')
    end



    def delete(database, tag)
      @storage.delete(database, tag)
    end



    def list_remote_snapshots(database)
      @rest_client.list(database)
    end



    def list_local_snapshots(database)
      @storage.list(database)
    end



  protected

    def _init_storage
      storage_factory = DatabaseRepository::Storage::StorageFactory.new
      @storage = storage_factory.build_for_configuration(@configuration['storage'])
    end



    def _init_db_driver_builder
      @database_driver_builder = DatabaseRepository::Database::DatabaseDriverBuilder.new(@configuration)
    end



    def _init_rest_client
      @rest_client = DatabaseRepository::Client.new('http://localhost:4567')
    end

  end
end
