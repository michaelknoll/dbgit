require 'sinatra/base'

module Sinatra
  module DatabaseRepository
    module DatabaseRepositoryServer

      def url_for(db_name, tag)
        "/#{db_name}/#{tag}"
      end

    end
  end
end
