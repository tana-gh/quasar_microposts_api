class UserSession < ApplicationRecord
  # :token, :user_id, :expires

  belongs_to :user
  validates :token,   presence: true, uniqueness: { case_sensitive: true }
  validates :expires, presence: true
  validates :user_id, presence: true
  
  EXPIRES_OFFSET = Rational(1, 24)
  
  def set_new_token
    self.token   = SecureRandom.hex(100)
    self.expires = DateTime.now + EXPIRES_OFFSET
  end
  
  def is_in_expires
    DateTime.now <= self.expires
  end
  
  def delete_session
    self.expires = DateTime.now - 1
  end
end
