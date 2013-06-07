FactoryGirlRails::RemoteApi::Engine.routes.draw do
  match ':factory' => 'factories#create', via: [:get, :post], defaults: { format: :json }
end
