require 'factory_girl_rails/remote_api/request'

module FactoryGirlRails
  module RemoteApi
    class RemoteFactory

      def self.model_from(factory_method, factory, attributes)
        final_attributes = FactoryGirlRails::RemoteApi::Request.new.get_response_for(factory_method, factory, attributes)
        new.instantiate_model(final_attributes, factory, attributes)
      end

      def instantiate_model(final_attributes, factory, attributes)
        model_instance = model_class(factory, attributes).new
        apply_attributes_to_instance(final_attributes, model_instance)
        model_instance
      end

    private

      def model_class(factory, attributes)
        class_name = attributes[:parent_factory] || factory.to_s
        class_name.camelize.constantize
      end

      def apply_attributes_to_instance(attributes, model_instance)
        attributes.each { |attr_name, attr_value| model_instance.public_send("#{attr_name}=", attr_value) }
      end

    end
  end
end
