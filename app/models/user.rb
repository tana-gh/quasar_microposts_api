class User < ApplicationRecord
  has_one  :user_session, dependent: :destroy
  has_many :micropsts   , dependent: :destroy
  has_many :followees, class_name:  'Follow',
                       foreign_key: 'follower_id',
                       dependent: :destroy
  has_many :followers, class_name:  'Follow',
                       foreign_key: 'followee_id',
                       dependent: :destroy
                       
  validates :name, presence: true,
                   length: { maximum: 60 },
                   format: { with: /\A[\-\w]+\z/ },
                   uniqueness: { case_sensitive: true }
  has_secure_password
  validates :password, presence: true,
                       length: { minimum: 4 }
end
