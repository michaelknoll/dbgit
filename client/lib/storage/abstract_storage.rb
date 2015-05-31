module DatabaseRepository
  module Storage

    #
    # Abstract class for a snapshot storage.
    #
    class AbstractStorage

      def initialize(storage_conf)
        @storage_configuration = storage_conf
      end



      #
      # This is the interface method for storing snapshots.
      #
      # _file_     The snapshot file that should be stored
      # _db_name_  The database name for which to store the file
      # _tag_      The tag name for the snapshot
      # _override_ If set to true, an existing snapshot with the same tag name will be overridden
      #
      def persist(file, db_name, tag, override = false)
        _persist(file, db_name, tag, override)
      end



      def get(db_name, tag)
        _get(db_name, tag)
      end



      #
      # This is the interface method for deleting a snapshot.
      #
      # _db_name_  The database name for which to delete the snapshot
      # _tag_      The tag name of the snapshot to be deleted
      def delete(db_name, tag)
        _delete(db_name, tag)
      end



      #
      # This is the interface method for listing snapshots for a given database name
      #
      # _db_name_  The database name for which to list the snapshots
      #
      def list(db_name)
        _list(db_name)
      end



    protected

      #
      # We force the concrete implementation to implement this method by raising an error.
      # TODO find out, what's the Ruby way of using an interface / abstract class.
      #
      def _persist(file, db_name, tag, override = false)
        raise 'Method not implemented! This exception occurs if you forgot to implement the _persist method in your concrete storage class!'
      end



      def _get(db_name, tag)
        raise 'Method not implemented! This exception occurs if you forgot to implement the _get method in your concrete storage class!'
      end



      def _delete(db_name, tag)
        raise 'Method not implemented! This exception occurs if you forgot to implement the _delete method in your concrete storage class!'
      end



      def _list(db_name)
        raise 'Method not implemented! This exception occurs if you forgot to implement the _list method in your concrete storage class!'
      end

    end
  end
end
