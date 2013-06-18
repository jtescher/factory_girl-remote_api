FactoryGirlRails::RemoteApi::Engine.routes.draw do
  get ':factory_method/:factory' => 'factories#show', defaults: { format: :json }
  match ':factory' => 'factories#create', via: [:get, :post], defaults: { format: :json }
end
