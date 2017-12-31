class UserSession < ApplicationRecord
  belongs_to :user
  validates :token,   presence: true, uniqueness: { case_sensitive: true }
  validates :user_id, presence: true
end
