Rails.application.routes.draw do
  resources :applications
  resources :eligibilities
  resources :schedules
  resources :companies
  resources :students
  devise_for :users
  root :to=>"companies#index"
  match "schedules/:schedule_id/new_eligibility" => "eligibilities#new", :as => "new_placement_eligibility", via: [:get, :post]
  match "schedules/:schedule_id/new_application" => "applications#new", :as => "new_placement_application", via: [:get, :post]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
