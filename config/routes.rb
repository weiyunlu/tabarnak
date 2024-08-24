Rails.application.routes.draw do
  get 'static_pages/home'
  get '/home', to: 'static_pages#home', as: :home
  post '/home', to: 'static_pages#swear_chain', as: :swear_chain

  Rails.application.routes.draw do
  get 'static_pages/home'
    root 'static_pages#home'
  end
end
