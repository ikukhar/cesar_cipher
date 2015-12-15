Rails.application.routes.draw do

  root 'page#index'
  get 'crypt' => 'page#crypt'
  get 'analyse_text' => 'page#analyse_text'

end
