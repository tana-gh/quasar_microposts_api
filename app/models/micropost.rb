class Micropost < ApplicationRecord
  # :message, :user_id

  belongs_to :user
  
  validates :message, presence: true,
                      length: { maximum: 140 }
  validates :user_id, presence: true
end
