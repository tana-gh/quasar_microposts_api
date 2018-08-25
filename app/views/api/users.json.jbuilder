json.status @status
json.users  @users.map do |item|
    json.id   item.id
    json.name item.name
    json.following item.followers.any? do |u|
        @user_session.user.id == u.id
    end
end
