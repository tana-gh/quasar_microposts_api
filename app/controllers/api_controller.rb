class ApiController < ApplicationController
  
  def signup
    user_name = params[:user_name]
    password  = params[:password]
    password_confirmation = params[:password_confirmation]
    
    user = User.new(name:     user_name,
                    password: password,
                    password_confirmation: password_confirmation)
    
    if user.save
      save_session(user.id)
      update_message
    else
      update_message false, 'Cannot signup.'
    end
    
    render 'status', formats: 'json', handlars: 'jbuilder'
  end
  
  def login
    user_name = params[:user_name]
    password  = params[:password]
    
    user = User.find_by(name: user_name)
    
    if user && user.authenticate(password)
      save_session(user.id)
      update_message
    else
      update_message false, 'Wrong user name or password.'
    end
    
    render 'status', formats: 'json', handlars: 'jbuilder'
  end
  
  def logout
    if !load_session.blank?
      save_session("")
      update_message
    else
      update_message false, 'Not Logined.'
    end
    
    render 'status', formats: 'json', handlars: 'jbuilder'
  end
  
  def is_login
    if !load_session.blank?
      update_message
    else
      update_message false, 'Not Logined.'
    end
    
    render 'status', formats: 'json', handlars: 'jbuilder'
  end
  
  def get_messages
    user = User.find_by_id(load_session)
    
    update_messages !user.nil?, Micropost.where(user: user)
    render 'messages', formats: 'json', handlars: 'jbuilder'
  end
  
  def post_message
    user = User.find_by_id(load_session)
    
    
  end
  
  def load_session
    cookies[:user_id]
  end
  
  def save_session(user_id)
    if user_id.blank?
      cookies.delete :user_id
    else
      cookies[:user_id] = { value: user_id, expires: 1.hour.from_now }
    end
    #response.set_cookie :user_id, user_id
  end
  
  def update_message(status = true, message = '')
    @status  = status
    @message = message
  end
  
  def update_messages(status = true, messages = [])
    @status   = status
    @messages = messages
  end
end
