module FactoryGirlRails
  module RemoteApi
    class FactoriesController < FactoryGirlRails::RemoteApi::ApplicationController
      respond_to :json

      def create
        @model = FactoryGirl.create(params[:factory], params[params[:factory]])
        respond_with @model
      end

      def show
        @model = FactoryGirl.attributes_for(params[:factory], params[params[:factory]])
        respond_with @model
      end

    end
  end
end
