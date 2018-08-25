json.status @status
json.users  @users.map do |item|
    json.id   item.id
    json.name item.name
end
