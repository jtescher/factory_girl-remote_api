require 'factory_girl_rails'
require 'factory_girl_rails/remote_api/engine'
require 'factory_girl_rails/remote_api/configuration'
require 'factory_girl_rails/remote_api/request'

module FactoryGirlRails
  module RemoteApi

    def self.configure
      yield configuration if block_given?
    end

    def self.configuration
      @configuration ||= FactoryGirlRails::RemoteApi::Configuration.new
    end

    def self.reset_configuration
      @configuration = nil
    end

    def self.create(factory, attributes = {})
      FactoryGirlRails::RemoteApi::Request.new.get_response_for(:create, factory, attributes)
    end

    def self.attributes_for(factory, attributes = {})
      FactoryGirlRails::RemoteApi::Request.new.get_response_for(:attributes_for, factory, attributes)
    end

  end
end
