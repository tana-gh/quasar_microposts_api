class ApiController < ApplicationController
  
  before_action :authenticate
  
  # 全Userを取得
  def get_users
    render_users(200, true, User.all)
  end

  # 指定されたMicropostを取得
  # :index - 先頭index
  # :count - 個数
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
  
  # Micropostを投稿する
  # :micropost - メッセージ内容
  def post_micropost
    message = params[:micropost]
    user    = @user_session.user
    
    mp = Micropost.new(message: message, user: user)
    
    if mp.save
      render_microposts(200, true, [mp])
    else
      render_status(400, false, 'Invalid micropost.')
    end
  end
end
