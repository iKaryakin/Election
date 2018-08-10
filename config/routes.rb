Rails.application.routes.draw do
  match "/404", :to => "errors#not_found", :via => :all
  match "/500", :to => "errors#internal_server_error", :via => :all

  resources :areas, :cameras, param: :area_slug do
    resources :cameras
  end

  devise_for :users

  # get 'areas/index'
  root to: "areas#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
