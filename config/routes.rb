Rails.application.routes.draw do
  resources :widgets, except: [:new, :edit]
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
