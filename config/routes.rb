Rails.application.routes.draw do
  post '/login', to: 'api#login'
end
