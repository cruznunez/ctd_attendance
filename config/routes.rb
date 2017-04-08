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

    resources :code_reviews, except: [:show, :edit] do
      collection do
        get ':date/edit' => 'code_reviews#edit', as: :edit # replaces edit
      end
    end
  end

  resources :students do
    collection do
      patch '', action: :index # for sortability
    end
  end

  resources :users
end
