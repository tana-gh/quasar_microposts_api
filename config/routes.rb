Rails.application.routes.draw do
  post '/api/signup',   to: 'user_api#signup'
  post '/api/login',    to: 'user_api#login'
  post '/api/logout',   to: 'user_api#logout'
  post '/api/is_login', to: 'user_api#is_login'
  post '/api/get_microposts', to: 'api#get_microposts'
  post '/api/post_micropost', to: 'api#post_micropost'
end
