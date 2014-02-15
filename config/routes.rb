Moeil::Application.routes.draw do

  devise_for :mailboxes, path: '',
    path_names: { sign_in: 'login', sign_out: 'logout' },
    controllers: { sessions: 'sessions' }

  namespace :admin do
    resources :domains, except: :show do
      resources :aliases, except: :show
      resources :mailboxes, except: :show
      resources :permissions, except: :show
    end
    resources :versions, only: :index
    post 'versions/:id/revert' => 'versions#revert', as: 'revert_version'
    post 'search' => 'searches#search'
  end

  get 'admin/test' => 'admin#test'

  post 'development_login' => 'development_login#update'

  resource :mailbox, only: [:edit, :update]

  devise_scope :mailbox do
    root to: 'sessions#new'
  end

end
