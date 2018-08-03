json.status     @status
json.microposts @microposts.map do |item|
    json.posted_at item.created_at
    json.user      item.user.name 
    json.micropost item.message   
end
