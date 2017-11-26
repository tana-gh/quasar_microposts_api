require 'json'

class ApiController < ApplicationController
  
  def login
    lp        = login_params
    user_name = lp['user_name']
    password  = lp['password']
    
    user = User.find_by(name: user_name)
    if user && user.authenticate(password)
      session[:user_id] = user.id
      
      @status  = true
      @message = ''
    else
      @status  = false
      @message = 'Wrong user name or password.'
    end
    
    render 'login', formats: 'json', handlars: 'jbuilder'
  end
  
  def strong_params
    params.require('body')
  rescue
    {}
  end
  
  def login_params
    JSON.parse(strong_params)
  rescue
    {}
  end
  
  def get_messages
    
  end
  
  def post_message
    
  end
end
