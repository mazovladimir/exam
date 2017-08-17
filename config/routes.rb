Rails.application.routes.draw do
  resource :welcome
  root to: "questions#index"

  devise_for :users 

  resources :users do
    resources :exam, controller: "examquestions"
    post "check_question", controller: "examquestions"
    #post "prev", controller: "examquestions"
    #get "next_question", controller: "examquestions" 
    #get "prev_question", controller: "examquestions" 
    #post "move_question", controller: "examquestions" 
  end

  resources :questions do
    resources :answers
  end

  get "results", controller: "examquestions"
  get "count_answer", controller: "questions"
end
