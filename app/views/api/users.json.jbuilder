me = @user_session.user
followers = me.followers
followees = me.followees

json.status @status
json.users  @users.map do |item|
    json.id   item.id
    json.name item.name
    json.following(followees.any? do |follow|
        follow.followee.id == item.id
    end)
    json.followed(followers.any? do |follow|
        follow.follower.id == item.id
    end)
end
