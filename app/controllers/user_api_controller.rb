class UserApiController < ApplicationController
  
  before_action :authenticate, except: [:signup, :login]
  
  def signup
    user_name = params[:user_name]
    password  = params[:password]
    password_confirmation = params[:password_confirmation]
    
    user = User.new(name:     user_name,
                    password: password,
                    password_confirmation: password_confirmation)
    
    if !user.save
      render_status(401, false, 'Cannot signup.')
      return
    end

    if save_new_session(user)
      render_token(200, true, user.user_session.token)
    else
      render_status(401, false, 'Cannot create session.')
    end
  end
  
  def login
    user_name = params[:user_name]
    password  = params[:password]

    user = User.find_by(name: user_name)
    
    if !user || !user.authenticate(password)
      render_status(401, false, 'Wrong user name or password.')
      return
    end

    if save_new_session(user)
      render_token(200, true, user.user_session.token)
    else
      render_status(401, false, 'Cannot create session.')
    end
  end
  
  def logout
    if @user_session.is_in_expires
      @user_session.delete_session
      @user_session.save
      render_status(200, true, 'Logouted.')
    else
      render_status(401, false, 'Not logined.')
    end
  end
  
  def is_login
    if @user_session.is_in_expires
      render_status(200, true, 'Logined.')
    else
      render_status(200, false, 'Not logined.')
    end
  end
  
  private
  
  def save_new_session(user)
    us = get_user_session(user)
    us.set_new_token
    us.save
  end
  
  def get_user_session(user)
    user.user_session || UserSession.new(user: user)
  end
end
