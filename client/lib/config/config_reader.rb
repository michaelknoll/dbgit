require 'JSON'

module DatabaseRepository

  module Config

    class Reader

      attr_reader :configuration

      def initialize(config_file)
        raise "Configuration file #{config_file} not found!" unless File.exists?(config_file)
        @configuration = JSON.parse(File.read(config_file))
      end

    end

  end

end