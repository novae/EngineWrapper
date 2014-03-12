EngineWrapper::Application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]
  resources :usuarios
  
  root 'static_pages#inicio'
  
  
  match '/signup',		to:'usuarios#new',				via:'get'
  match '/signin', 		to:'sessions#new', 				via:'get'
  match '/signout', 	to:'sessions#destroy', 			via:'delete'

  match '/', 			to:'static_pages#inicio', 		via:'get'
  match '/lecciones',	to:'static_pages#lecciones',	via:'get'
  match '/contacto',	to:'static_pages#contacto', 	via:'get'
  
  
end
