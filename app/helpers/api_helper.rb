module ApiHelper
  
  def update_render_message(status = true, message = '')
    @status  = status
    @message = message
  end
  
  def update_render_messages(status = true, messages = [])
    @status   = status
    @messages = messages
  end
end
