require 'net/http'
require 'json'

module FactoryGirlRails
  module RemoteApi
    class Request

      def get_response_for(factory_method, factory, attributes)
        uri = uri_for(factory_method, factory)
        uri.query = attributes_as_query(factory, attributes)
        JSON.parse(Net::HTTP.get_response(uri).body)
      end

    private

      def uri_for(factory_method, factory)
        factories_path = "#{configuration.server_url}#{configuration.server_mount_path}"
        factories_path << "/#{factory_method}" if factory_method != :create
        factories_path << "/#{factory}"
        URI(factories_path)
      end

      def configuration
        FactoryGirlRails::RemoteApi.configuration
      end

      def attributes_as_query(factory, attributes)
        attributes = { factory.to_sym => attributes } if attributes != {}
        attributes.to_query
      end

    end
  end
end
