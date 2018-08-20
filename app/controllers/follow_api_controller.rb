class FollowApiController < ApplicationController
  
  before_action :authenticate

  def get_followees
    followees = @user_session.user.followees.map { |x| x.followee }
    render_users(200, true, followees)
  end

  def get_followers
    followers = @user_session.user.followers.map { |x| x.follower }
    render_users(200, true, followers)
  end

  # :user - フォローされるUser
  def follow
    name     = params[:user]
    followee = User.find_by(name: name)

    if !followee
      render_status(401, false, 'Cannot find user.')
      return
    end

    follower = @user_session.user
    follow   = Follow.find_by(followee: followee, follower: follower)

    if follow
      render_status(401, false, 'Already followed.')
      return
    end

    new_follow = Follow.new followee: followee, follower: follower

    if new_follow.save
      render_status(200, true, 'Followed.')
    else
      render_status(401, false, 'Cannot follow.')
    end
  end

  # :user - フォローを外されるUser
  def unfollow
    name     = params[:user]
    followee = User.find_by(name: name)

    if !followee
      render_status(401, false, 'Cannot find user.')
      return
    end

    follower = @user_session.user
    follow   = Follow.find_by(followee: followee, follower: follower)

    if !follow
      render_status(401, false, 'Already unfollowed.')
      return
    end

    if follow.delete
      render_status(200, true, 'Unfollowed.')
    else
      render_status(401, false, 'Cannot unfollow.')
    end
  end

end
