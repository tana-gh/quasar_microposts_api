json.status @status
json.users  @users.map do |item|
    json.id   item.id
    json.name item.name
    json.following(item.followers.any? do |follow|
        p 'following'
        p follow.follower.id
        @user_session.user.id == follow.follower.id
    end)
    json.followed(item.followees.any? do |follow|
        p 'followed'
        p follow.followee.id
        @user_session.user.id == follow.followee.id
    end)
end
