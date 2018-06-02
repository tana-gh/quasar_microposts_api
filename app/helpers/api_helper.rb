module ApiHelper
  
  private
  
  def render_token(status, json_status, token)
    @status = json_status
    @token  = token
    render 'token', formats: 'json', handlars: 'jbuilder', status: status
  end
  
  def render_status(status, json_status, message)
    @status  = json_status
    @message = message
    render 'status', formats: 'json', handlars: 'jbuilder', status: status
  end

  def render_users(status, json_status, users)
    @status = json_status
    @users  = users
    render 'users', formats: 'json', handlars: 'jbuilder', status: status
  end
  
  def render_microposts(status, json_status, microposts)
    @status     = json_status
    @microposts = microposts
    render 'microposts', formats: 'json', handlars: 'jbuilder', status: status
  end
  
  def authenticate
    @user_session = authenticate_user
    if @user_session.nil?
      render_status(401, false, 'Failed to authenticate.')
    end
  end
  
  def authenticate_user
    authenticate_with_http_token do |token, options|
      UserSession.find_by(token: token)
    end
  end
end
