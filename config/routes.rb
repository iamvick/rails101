Rails.application.routes.draw do
  devise_for :users
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    resources:groups
    resources:welcome
    resources:application
    #root 'welcome#index' 
    root 'groups#index' 
end
