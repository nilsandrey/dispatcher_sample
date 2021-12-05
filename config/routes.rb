Rails.application.routes.draw do
  Healthcheck.routes(self) # e.g. /pulse
  resources :drones, only: [:index, :create, :destroy, :update] do
    member do             
      get 'check_battery' # Check battery level for a drone
    end
  end
    
end
