module ApiHelper
  
  private
  
  def update_render_message(status = true, message = '')
    @status  = status
    @message = message
  end
  
  def update_render_messages(status = true, messages = [])
    @status   = status
    @messages = messages
  end
  
  def authenticate
    @user = authenticate_user
    if @user.nil?
      update_render_message false, 'Failed to authenticate.'
      render 'status', formats: 'json', handlers: 'jbuilder'
    end
  end
  
  def authenticate_user
    authenticate_with_http_token do |token, options|
      UserSession.find_by(token: token)
    end
  end
end
