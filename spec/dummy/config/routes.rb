Rails.application.routes.draw do
  mount FactoryGirlRails::RemoteApi::Engine => '/factories'
end
