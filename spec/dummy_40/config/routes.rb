Rails.application.routes.draw do

  mount FactoryGirl::RemoteApi::Engine => "/factories"
end
