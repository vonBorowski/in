Rails.application.routes.draw do
  root 'dashboard#index'
  devise_for :users, controllers: { registrations: 'registrations' }

  shallow do
    resources :organization do
      resources :project do
        resources :task
      end
    end
    resources :user do
      resources :time_entry
    end

    as :user do
      get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
      put 'users' => 'devise/registrations#update', :as => 'user_registration'
    end
  end

  resources :project, only: :index
  resources :task, only: :index

  get '/user/:user_id/time_entry(/project/:project_id)(/:year(/:month(/:day)))' => 'time_entry#index', constraints: {
    year:       /\d{4}/,
    month:      /\d{1,2}/,
    day:        /\d{1,2}/
  }

  get '/user/:user_id/time_entry((/task/:task_id))(/:year(/:month(/:day)))' => 'time_entry#index', constraints: {
    year:       /\d{4}/,
    month:      /\d{1,2}/,
    day:        /\d{1,2}/
  }
end

