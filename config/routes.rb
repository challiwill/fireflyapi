Rails.application.routes.draw do
  resources :groups, except: [:new, :edit] do
    resources :users, as: 'members', path: 'members'
  end
  resources :users, except: [:new, :edit] do
    resources :groups
  end
end
