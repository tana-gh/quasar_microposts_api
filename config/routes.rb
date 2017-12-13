Rails.application.routes.draw do
  get '/api/signup',   to: 'api#signup'
  get '/api/login',    to: 'api#login'
  get '/api/logout',   to: 'api#logout'
  get '/api/is_login', to: 'api#is_login'
  get '/api/get_messages', to: 'api#get_messages'
  get '/api/post_message', to: 'api#post_message'
  post '/api/signup',   to: 'api#signup'
  post '/api/login',    to: 'api#login'
  post '/api/logout',   to: 'api#logout'
  post '/api/is_login', to: 'api#is_login'
  post '/api/get_messages', to: 'api#get_messages'
  post '/api/post_message', to: 'api#post_message'
end
