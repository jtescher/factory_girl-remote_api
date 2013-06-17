require 'spec_helper'

describe FactoryGirlRails::RemoteApi::Request do
  describe '#get_response_for' do
    let(:config) { FactoryGirlRails::RemoteApi.configuration }

    it 'returns the parsed json if no root is set' do
      uri = URI("#{config.server_url}#{config.server_mount_path}/attributes_for/user?user%5Bfirst_name%5D=James")
      Net::HTTP.should_receive(:get_response).with(uri).and_return(stub(:response, body: '{ "first_name": "James"}'))
      response = FactoryGirlRails::RemoteApi::Request.new.get_response_for(:attributes_for, :user, first_name: "James")
      expect(response).to eq("first_name" => "James")
    end

    it 'returns the model inside the root json element if present' do
      uri = URI("#{config.server_url}#{config.server_mount_path}/attributes_for/user?user%5Bfirst_name%5D=James")
      stub_response = stub(:response, body: '{ "user": {"first_name": "James"}}')
      Net::HTTP.should_receive(:get_response).with(uri).and_return(stub_response)
      response = FactoryGirlRails::RemoteApi::Request.new.get_response_for(:attributes_for, :user, first_name: "James")
      expect(response).to eq("first_name" => "James")
    end

    it 'returns the model inside the root json element if the parent factory is set' do
      url = "#{config.server_url}#{config.server_mount_path}/authenticated_user"
      params = '?authenticated_user%5Bfirst_name%5D=James&authenticated_user%5Bparent_factory%5D=user'
      uri = URI(url + params)
      stub_response = stub(:response, body: '{ "user": {"first_name": "James"}}')
      Net::HTTP.should_receive(:get_response).with(uri).and_return(stub_response)
      response = FactoryGirlRails::RemoteApi::Request.new.get_response_for(:create,
                                                                           :authenticated_user,
                                                                           first_name: 'James', parent_factory: 'user')
      expect(response).to eq("first_name" => "James")
    end
  end
end
