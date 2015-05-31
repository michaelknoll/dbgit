require 'fileutils'

module DatabaseRepository
  module Storage

    #
    # Class implements a file storage for database snapshots
    #
    # The class gets a storage_folder from the configuration
    # into which all snapshots are stored. It then creates a
    # subfolder for each database in which a file for each
    # tag is created where the snapshot is then stored.
    #
    class FileStorage < DatabaseRepository::Storage::AbstractStorage

      def initialize(*args)
        super
        unless @storage_configuration['storage_folder']
          raise ArgumentError, 'No storage_folder configuration was given in storage_configuration! Cannot instantiate FileStorage without this setting!'
        end
        @storage_folder = @storage_configuration['storage_folder']
        _create_folder(@storage_folder)
      end



    protected

      def _persist(file, db_name, tag, override = false)
        storage_folder = _storage_folder_for(db_name)
        _create_folder(storage_folder)
        storage_path = _snapshot_path_for(db_name, tag)
        if  !File.exists?(storage_path) || override
          begin
            FileUtils.mv(file.path, storage_path)
          rescue => e
            raise Exception, "Could not move file #{file.path} to #{storage_path}. Error: #{e.message}"
          end
        end
        storage_path
      end



      def _get(db_name, tag)
        storage_path = _snapshot_path_for(db_name, tag)
        if File.exists?(storage_path)
          File.new(storage_path)
        else
          raise Exception, "No snapshot exists for db_name #{db_name} and tag #{tag} -  search path: #{storage_path}"
        end
      end



      def _delete(db_name, tag)
        storage_path = _snapshot_path_for(db_name, tag)
        if File.exists?(storage_path)
          begin
            File.delete(storage_path)
          rescue => e
            raise Exception, "Could not delete snapshot #{storage_path}. Error: #{e.message}"
          end
        end
      end



      def _list(db_name)
        storage_folder = _storage_folder_for(db_name)
        snapshots = Dir.glob("#{storage_folder}/*")
        snapshots.map! {|snapshot| File.basename(snapshot)}
        snapshots
      end

    private

      def _create_folder(folder)
        unless Dir.exists?(folder)
          begin
            Dir.mkdir(folder)
          rescue => e
            raise Exception, "Could not create folder '#{folder}' - error: #{e.message}"
          end
        end
      end



      def _storage_folder_for(db_name)
        "#{@storage_folder}/#{db_name}"
      end



      def _snapshot_path_for(db_name, tag)
        "#{_storage_folder_for(db_name)}/#{tag}"
      end

    end
  end
end