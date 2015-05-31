module DatabaseRepository

  module Database

    class DatabaseDriverBuilder

      def initialize(configuration)
        @configuration = configuration
      end

      # @return DatabaseRepository::Database::DatabaseDriver
      def build_driver_for_database(database_name)
        database_configuration= @configuration['databases'][database_name]
        raise "No database configuration can be found for #{database_name}" if database_name == nil
        _build_for_configuration(database_configuration)
      end

    protected

      def _build_for_configuration(database_configuration)
        require_relative "./#{database_configuration['driver']}_driver"
        driver_class_name = "#{database_configuration['driver'].capitalize}Driver"
        Object.const_get("DatabaseRepository::Database::#{driver_class_name}").new(database_configuration)
      end

    end

  end

end