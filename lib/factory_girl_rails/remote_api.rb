require 'factory_girl_rails'
require 'factory_girl_rails/remote_api/engine'
require 'factory_girl_rails/remote_api/configuration'
require 'factory_girl_rails/remote_api/remote_factory'

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
      FactoryGirlRails::RemoteApi::RemoteFactory.model_from(:create, factory, attributes)
    end

    def self.attributes_for(factory, attributes = {})
      FactoryGirlRails::RemoteApi::RemoteFactory.model_from(:attributes_for, factory, attributes)
    end

  end
end
