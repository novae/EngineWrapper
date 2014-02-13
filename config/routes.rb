EngineWrapper::Application.routes.draw do
  get "static_pages/Inicio"
  get "static_pages/Lecciones"
  get "static_pages/Contacto"
  root 'static_pages#Inicio'
end
