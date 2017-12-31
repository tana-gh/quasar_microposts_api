class UserApiController < ApplicationController

  def signup
    user_name = params[:user_name]
    password  = params[:password]
    password_confirmation = params[:password_confirmation]
    
    user = User.new(name:     user_name,
                    password: password,
                    password_confirmation: password_confirmation)
    
    if user.save
      save_session(user.id)
      update_render_message
    else
      update_render_message false, 'Cannot signup.'
    end
    
    render 'status', formats: 'json', handlars: 'jbuilder'
  end
  
  def login
    user_name = params[:user_name]
    password  = params[:password]
    
    user = User.find_by(name: user_name)
    
    if user && user.authenticate(password)
      save_session(user.id)
      update_render_message
    else
      update_render_message false, 'Wrong user name or password.'
    end
    
    render 'status', formats: 'json', handlars: 'jbuilder'
  end
  
  def logout
    if !load_session.blank?
      delete_session
      update_render_message
    else
      update_render_message false, 'Not Logined.'
    end
    
    render 'status', formats: 'json', handlars: 'jbuilder'
  end
  
  def is_login
    if !load_session.blank?
      update_render_message
    else
      update_render_message false, 'Not Logined.'
    end
    
    render 'status', formats: 'json', handlars: 'jbuilder'
  end
end
