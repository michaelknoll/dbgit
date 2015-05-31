module DatabaseRepository

  module Database

    class DatabaseDriver

      def initialize(configuration)
        @configuration = configuration
      end

      def debug_configuration
        puts @configuration.inspect
      end

      def make_snapshot(snapshot_path)
        _make_snapshot(snapshot_path)
      end

      def apply_snapshot(snapshot)
        _apply_snapshot(snapshot)
      end

    protected

      def _make_snapshot(snapshot_path)
        raise '_make_snapshot is not implemented for this driver!'
      end

      def _apply_snapshot(snapshot)
        raise '_apply_snapshot is not implemented for this driver!'
      end

    end

  end

end