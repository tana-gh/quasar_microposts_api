Rails.application.routes.draw do
  post '/api/signup',   to: 'user_api#signup'
  post '/api/login',    to: 'user_api#login'
  post '/api/logout',   to: 'user_api#logout'
  post '/api/is_login', to: 'user_api#is_login'
  post '/api/get_messages', to: 'api#get_messages'
  post '/api/post_message', to: 'api#post_message'
end
