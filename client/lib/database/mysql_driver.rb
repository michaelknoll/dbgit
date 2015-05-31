require_relative './database_driver'
require_relative '../exception/database_exception'

module DatabaseRepository

  module Database

    class MysqlDriver < DatabaseDriver

      def to_s
        'MySQL Database Driver'
      end



    protected

      def _make_snapshot(snapshot_path)
        dump_command = _create_command(@configuration)
        command = "#{dump_command} > #{snapshot_path}"
        begin
          `#{command}`
        rescue => e
          raise Dbgit::DatabaseException, "An error occurred when trying to run `#{command}`. Error: #{e.message}"
        end
      end



      def _apply_snapshot(snapshot)
        command = ''
        @configuration['credentials'].tap do |credentials|
          command = "mysql -h #{credentials['host']} -u #{credentials['user']} #{'-p' + credentials['password'] if credentials['password'] && credentials['password'] != ''} #{credentials['database']}"
        end
        begin
          `#{command} < #{snapshot.path}`
        rescue => e
          raise Dbgit::DatabaseException, "An error occurred when trying to import snapshot #{snapshot.path} into #{@configuration['credentials']['database']}. Error: #{e.message}"
        end
      end



      def _create_command(configuration)
        command = ''
        configuration['credentials'].tap do |credentials|
          command = "mysqldump -h #{credentials['host']} -u #{credentials['user']} #{'-p' + credentials['password'] if credentials['password'] && credentials['password'] != ''} #{credentials['database']}"
        end
        unless configuration['lock']
          command = command + ' --lock-tables=false'
        end
        configuration['ignore_tables'].each { |ignore_table| command = command + " --ignore-table=#{configuration['credentials']['database']}.#{ignore_table}" }
        command
      end

    end

  end

end