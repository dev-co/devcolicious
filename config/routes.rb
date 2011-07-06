Devcolicious::Application.routes.draw do

  root :to => 'home#index'

  # - Devise Section -
  devise_for :users
  # - End Devise Section -

  # - Bookmarks Section -
  get '/bookmarks/import' => 'bookmarks#import',
      :as => :import_bookmarks
  post '/bookmarks/import/:provider' => 'bookmarks#import_from_provider',
      :as => :import_bookmarks_from_provider
  resources :bookmarks
  # - End Bookmarks Section -

  # - Searches Section -
  post '/searches/bookmarks_by_tag'
  # - End Searches Section -

end
