module FactoryGirl
  module RemoteApi
    class Engine < ::Rails::Engine
      isolate_namespace FactoryGirl::RemoteApi
    end
  end
end
