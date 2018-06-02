class ApiController < ApplicationController
  
  before_action :authenticate
  
  def get_users
    render_users(200, true, User.all)
  end

  def get_microposts
    render_microposts(200, true, Micropost.where(user: @user_session.user))  # TODO 今は自分のMicropostのみ
  end
  
  def post_micropost
    message = params[:micropost]
    user    = @user_session.user
    
    mp = Micropost.new(message: message, user: user)
    
    if mp.save
      render_status(200, true, 'OK.')
    else
      render_status(400, false, 'Invalid micropost.')
    end
  end
end
