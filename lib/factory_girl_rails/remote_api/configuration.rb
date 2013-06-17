module FactoryGirlRails
  module RemoteApi
    class Configuration
      attr_reader :server_url, :server_mount_path

      def initialize
        @server_url = 'http://localhost:3000'
        @server_mount_path = '/factories'
      end

      def server_url=(server_url)
        @server_url = server_url.gsub(/\/$/, '')
      end

      def server_mount_path=(server_mount_path)
        @server_mount_path = "/#{server_mount_path}".squeeze('/').gsub(/\/+\Z/, '')
      end

    end
  end
end
