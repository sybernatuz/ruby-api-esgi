class User < ApplicationRecord
  has_secure_password
  has_many :comments
  has_many :posts
  validates :username, presence: true, uniqueness: true
  validates :role, presence: true
end
