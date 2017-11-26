class User < ApplicationRecord
  has_many :micropst
  validates :name, presence: true,
                   length: { maximum: 60 },
                   format: { with: /\A[\-\w]+\z/ },
                   uniqueness: { case_sensitive: true }
  has_secure_password
  validates :password, presence: true,
                       length: { minimum: 4 }
end
