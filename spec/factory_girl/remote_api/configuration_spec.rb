require 'spec_helper'

describe FactoryGirl::RemoteApi::Configuration do
  after(:each) { FactoryGirl::RemoteApi.reset_configuration }

  describe '#server_url=' do
    it 'removes trailing slashes' do
      FactoryGirl::RemoteApi.configure { |config| config.server_url = 'http://localhost:1234/' }
      expect(FactoryGirl::RemoteApi.configuration.server_url).to eq('http://localhost:1234')
    end
  end

  describe '#server_mount_path=' do
    it 'adds leading slash if absent' do
      FactoryGirl::RemoteApi.configure { |config| config.server_mount_path = 'models' }
      expect(FactoryGirl::RemoteApi.configuration.server_mount_path).to eq('/models')
    end

    it 'removes trailing slash if present' do
      FactoryGirl::RemoteApi.configure { |config| config.server_mount_path = '/models/' }
      expect(FactoryGirl::RemoteApi.configuration.server_mount_path).to eq('/models')
    end
  end
end
