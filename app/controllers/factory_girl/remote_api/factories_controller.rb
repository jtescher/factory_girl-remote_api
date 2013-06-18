module FactoryGirl
  module RemoteApi
    class FactoriesController < FactoryGirl::RemoteApi::ApplicationController
      respond_to :json

      def create
        @model = FactoryGirl.create(params[:factory], factory_attributes)
        respond_with @model
      end

      def show
        @model = FactoryGirl.attributes_for(params[:factory], factory_attributes)
        respond_with @model
      end

    private

      def factory_attributes
        params[params[:factory]].try(:except, :parent_factory)
      end

    end
  end
end
