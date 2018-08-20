Rails.application.routes.draw do
  post '/api/signup'  , to: 'user_api#signup'
  post '/api/login'   , to: 'user_api#login'
  post '/api/logout'  , to: 'user_api#logout'
  post '/api/is_login', to: 'user_api#is_login'
  post '/api/get_users'     , to: 'api#get_users'
  post '/api/get_microposts', to: 'api#get_microposts'
  post '/api/post_micropost', to: 'api#post_micropost'
  post '/api/get_followees' , to: 'follow_api#get_followees'
  post '/api/get_followers' , to: 'follow_api#get_followers'
  post '/api/follow'        , to: 'follow_api#follow'
  post '/api/unfollow'      , to: 'follow_api#unfollow'

  match '*path' => 'options_request#preflight', via: :options
end
