FactoryGirlRails::RemoteApi::Engine.routes.draw do
  get 'attributes_for/:factory' => 'factories#show', defaults: { format: :json }
  match ':factory' => 'factories#create', via: [:get, :post], defaults: { format: :json }
end
