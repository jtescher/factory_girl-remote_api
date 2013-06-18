require 'spec_helper'

describe FactoryGirlRails::RemoteApi::Configuration do
  after(:each) { FactoryGirlRails::RemoteApi.reset_configuration }

  describe '#server_url=' do
    it 'removes trailing slashes' do
      FactoryGirlRails::RemoteApi.configure { |config| config.server_url = 'http://localhost:1234/' }
      expect(FactoryGirlRails::RemoteApi.configuration.server_url).to eq('http://localhost:1234')
    end
  end

  describe '#server_mount_path=' do
    it 'adds leading slash if absent' do
      FactoryGirlRails::RemoteApi.configure { |config| config.server_mount_path = 'models' }
      expect(FactoryGirlRails::RemoteApi.configuration.server_mount_path).to eq('/models')
    end

    it 'removes trailing slash if present' do
      FactoryGirlRails::RemoteApi.configure { |config| config.server_mount_path = '/models/' }
      expect(FactoryGirlRails::RemoteApi.configuration.server_mount_path).to eq('/models')
    end
  end
end
