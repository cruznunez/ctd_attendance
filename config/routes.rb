Rails.application.routes.draw do
  root 'pages#home'

  devise_for :users

  resources :attendances, only: :destroy

  resources :courses do
    resources :semesters do
      member do
        get :attendance
      end
    end
  end

  resources :projects

  resources :students do
    collection do
      patch '', action: :index
    end
  end

  resources :users
end
