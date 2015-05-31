module DatabaseRepository
  module Storage

    #
    # Class implements a factory for a snapshot storage.
    #
    class StorageFactory

      def build_for_configuration(storage_config)
        @storage_configuration = storage_config
        _build
      end

    protected

      def _build
        storage_class_name = @storage_configuration['storage_engine']
        Object.const_get(storage_class_name).new(@storage_configuration)
      end

    end
  end
end
