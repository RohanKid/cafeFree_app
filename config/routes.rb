Rails.application.routes.draw do
  get 'sessions/new'
  root "static_pages#home"
  get  "/signup",  to: "employees#new"
  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"
  patch "/attendances",  to: "attendances#create"
  resources :employees
  resources :attendances,          only: [:new, :create, :edit, :update, :destroy]
end
