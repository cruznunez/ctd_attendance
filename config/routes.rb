Rails.application.routes.draw do
  root 'pages#home'
  get '/preview_review' => 'code_reviews#preview'

  devise_for :users

  resources :attendances, only: :destroy

  resources :courses do
    resources :semesters do
      member do
        get :attendance
      end
    end
  end

  resources :projects do
    collection do
      patch '', action: :index # for sortability
    end

    resources :stand_ups, except: [:show, :edit] do
      collection do
        get ':date/edit' => 'stand_ups#edit', as: :edit # for a cleaner url
      end
    end

    resources :code_reviews, except: [:show, :edit, :new] do
      collection do
        patch '', action: :index # need this for sorting columns in table
        get '/form' => 'code_reviews#form' # combines new and edit actions into one
        # get ':date/edit' => 'code_reviews#edit', as: :edit # replaces edit
      end
    end
  end

  resources :students do
    collection do
      put '', action: :index # for search
      patch '', action: :index # for sortability
    end
  end

  resources :users
end
