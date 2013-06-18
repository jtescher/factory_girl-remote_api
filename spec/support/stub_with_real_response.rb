module StubWithRealResponse
  def stub_with_real_response(path)
    FactoryGirlRails::RemoteApi.reset_configuration
    visit [config.server_mount_path, path].join
    uri = URI([config.server_url, config.server_mount_path, path].join)
    Net::HTTP.should_receive(:get_response).with(uri).and_return(stub(:response, body: page.body))
  end
end

RSpec.configure do |config|
  config.include StubWithRealResponse
end
