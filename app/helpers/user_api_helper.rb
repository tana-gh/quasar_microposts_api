module UserApiHelper
  
  def user_from_token(token)
    user = UserSession.find_by(token: token)&.user
    if user
      if is_in_expires(user, default_expires)
        user
      else
        delete_session(user)
        nil
      end
    else
      nil
    end
  end
  
  def user_to_token(user)
    if user.present?
      token = UserSession.find_by(user: user)&.token
      
      if token.nil?
        create_token(user)
      elsif is_in_expires(user, default_expires)
        token
      else
        delete_session(user)
        nil
      end
    else
      nil
    end
  end
  
  def delete_session(user)
    UserSession.find_by(user: user)&.delete
  end
  
  private
  
  def default_expires
    Rational(1, 24)
  end
  
  def expires(user, offset)
    user.created_at + default_expires
  end
  
  def is_in_expires(user, offset)
    Datetime.now <= expires
  end
  
  def create_token(user)
    token = SecureRandom.hex(100)
    us = UserSession.new token: token, user: user
    us.save
  end
end
