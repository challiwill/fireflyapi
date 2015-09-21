Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  resources :groups, except: [:new, :edit] do
    resources :users, as: 'members', path: 'members'
    resources :trips
  end
  resources :users, except: [:new, :edit] do
    resources :groups
    resources :trips
  end
  resources :trips, except: [:new, :edit]
end
