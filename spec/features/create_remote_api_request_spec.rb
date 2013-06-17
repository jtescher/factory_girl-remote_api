require 'spec_helper'

feature 'Create remote API request' do
  let(:config) { FactoryGirlRails::RemoteApi.configuration }

  scenario 'create request for user model' do
    uri = URI("#{config.server_url}#{config.server_mount_path}/user?")
    Net::HTTP.should_receive(:get_response).with(uri).and_return(stub(:response, body: '{}'))
    FactoryGirlRails::RemoteApi.create(:user)
  end

  scenario 'create request for user model with specific attributes' do
    uri = URI("#{config.server_url}#{config.server_mount_path}/user?user%5Bfirst_name%5D=James")
    Net::HTTP.should_receive(:get_response).with(uri).and_return(stub(:response, body: '{}'))
    FactoryGirlRails::RemoteApi.create(:user, first_name: 'James')
  end

  scenario 'create request for attributes of a user without persisting it' do
    uri = URI("#{config.server_url}#{config.server_mount_path}/attributes_for/user?user%5Bfirst_name%5D=James")
    Net::HTTP.should_receive(:get_response).with(uri).and_return(stub(:response, body: '{}'))
    FactoryGirlRails::RemoteApi.attributes_for(:user, first_name: 'James')
  end
end
