Devcolicious::Application.routes.draw do

  root :to => 'home#index'

  # - Devise Section -
  devise_for :users

end
