EngineWrapper::Application.routes.draw do
  resources :usuarios
  root 'static_pages#inicio'
	match '/', to:'static_pages#inicio', via:'get'
  match '/lecciones', to:'static_pages#lecciones', via:'get'
  match '/contacto', to:'static_pages#contacto', via:'get'
  match '/ingresar',to:'usuarios#new', via:'get'
  
end
