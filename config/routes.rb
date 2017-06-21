Rails.application.routes.draw do
  root to: "questions#index"

  devise_for :users 

  resources :users do
    resources :questions, controller: 'examquestions', only: [:create]
    get 'next_question', to: 'examquestions#next_question'
    get 'prev_question', to: 'examquestions#prev_question'
  end

  resources :questions do
    resources :answers
  end
end
