Devcolicious::Application.routes.draw do

  root :to => 'home#index'

  # - Devise Section -
  devise_for :users
  # - End Devise Section -

  # - Bookmarks Section -
  resources :bookmarks
  # - End Bookmarks Section -

end
