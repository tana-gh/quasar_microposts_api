class ApiController < ApplicationController
  
  before_action :authenticate
  
  def get_users
    render_users(200, true, User.all)
  end

  def get_microposts
    index = params[:index].to_i
    count = params[:count].to_i

    if !index    ||
       !count    ||
       index < 0 ||
       count < 0
      render_status(400, false, 'Invalid params.')
      return
    end

    users = @user_session.user.followees.to_a << @user_session.user

    mps = Micropost.all.where(user: users)
                       .drop(index)
                       .take(count)

    render_microposts(200, true, mps)
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
