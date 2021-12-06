Rails.application.routes.draw do
  Healthcheck.routes(self) # e.g. /pulse

  resources :drones, only: %i[index create destroy update show] do
    member do
      get 'check_battery' # Check battery level for a drone
      patch 'ready' # Drone set to LOADED state
      patch 'go' # Drone set to DELIVERING state
      post 'load_medication' # Loading a drone with medication items
      post 'cancel'
    end
  end

  resources :medications, only: [:index]
end
