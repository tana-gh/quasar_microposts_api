class ApiController < ApplicationController
  
  def get_messages
    user = User.find_by_id(load_session)
    
    update_render_messages !user.nil?, Micropost.where(user: user)  # TODO 今は自分のMicropostのみ
    render 'messages', formats: 'json', handlars: 'jbuilder'
  end
  
  def post_message
    user = User.find_by_id(load_session)
    
    
  end
end
