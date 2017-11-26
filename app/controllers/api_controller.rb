class ApiController < ApplicationController
  
  def login
    # TODO JSON
    #user_name
    #password
    
    user = User.find_by(name: user_name)
    if user && user.authenticate(password)
      session[:user_id] = user.id
      # TODO Success
    else
      # TODO Error
    end
  end
  
  def get_messages
    
  end
  
  def post_message
    
  end
end
