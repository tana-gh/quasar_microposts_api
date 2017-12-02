require 'json'

class ApiController < ApplicationController
  
  def login
    user_name = params[:user_name]
    password  = params[:password]
    
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
  
  def get_messages
    
  end
  
  def post_message
    
  end
end
