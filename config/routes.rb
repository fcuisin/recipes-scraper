Rails.application.routes.draw do
  get 'recipes/new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'recipes#new'
end
