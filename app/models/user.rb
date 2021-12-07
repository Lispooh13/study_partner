class User < ApplicationRecord
  before_save { self.email = email.downcase }#DB保存前に小文字に変換
  
  validates :name,presence: true
  validates :email, presence: true, uniqueness: true
  
  has_secure_password validations: true
end