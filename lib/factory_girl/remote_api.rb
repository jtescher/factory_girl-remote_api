require 'factory_girl'
require 'factory_girl_rails'
require 'factory_girl/remote_api/engine'
require 'factory_girl/remote_api/configuration'
require 'factory_girl/remote_api/remote_factory'

module FactoryGirl
  module RemoteApi

    def self.configure
      yield configuration if block_given?
    end

    def self.configuration
      @configuration ||= FactoryGirl::RemoteApi::Configuration.new
    end

    def self.reset_configuration
      @configuration = nil
    end

    def self.create(factory, attributes = {})
      FactoryGirl::RemoteApi::RemoteFactory.model_from(:create, factory, attributes)
    end

    def self.build(factory, attributes = {})
      FactoryGirl::RemoteApi::RemoteFactory.model_from(:build, factory, attributes)
    end

    def self.attributes_for(factory, attributes = {})
      FactoryGirl::RemoteApi::Request.new.get_response_for(:attributes_for, factory, attributes)
    end

  end
end
