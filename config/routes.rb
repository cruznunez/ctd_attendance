Rails.application.routes.draw do
  get 'attendances/destroy'

  root 'pages#home'
  devise_for :users
  resources :courses do
    resources :semesters do
      member do
        get :attendance
      end
    end
  end
  resources :students do
    collection do
      patch '', action: :index
    end
  end
  resources :users
  resources :attendances, only: :destroy
end
