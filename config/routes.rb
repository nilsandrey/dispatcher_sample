Rails.application.routes.draw do
  Healthcheck.routes(self) # e.g. /pulse
  resources :drones, only: [:index, :create, :destroy, :update] do
    member do             
      get 'check_battery' # Check battery level for a drone
      patch 'ready' # Drone set to LOADED state
      patch 'go' # Drone set to DELIVERING state
    end
  end
    
end
