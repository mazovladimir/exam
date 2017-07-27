Rails.application.routes.draw do
  resource :welcome
  root to: "questions#index"

  devise_for :users 

  resources :users do
    resources :exam, controller: "examquestions"
    get "next_question", controller: "examquestions" 
    get "prev_question", controller: "examquestions" 
  end

  resources :questions do
    resources :answers
  end
end
