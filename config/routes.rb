EngineWrapper::Application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]
  root 'static_pages#inicio'
  resources :usuarios
  
  match '/registrarse',	to:'usuarios#new',			via:'get'
  match '/entrar', 			to:'sessions#new', 			via:'get'
  match '/salir', 			to:'sessions#destroy', 	via: :delete

  match '/', 			to:'static_pages#inicio', 				via:'get'
  match '/lecciones',	to:'static_pages#lecciones',	via:'get'
  match '/contacto',	to:'static_pages#contacto', 	via:'get'
  
  
end
