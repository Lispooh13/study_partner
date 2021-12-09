class Blog < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true
  validates :subject, presence: true
  validates :subject, length: { maximum: 100 }
  validates :body, presence: true
  
  has_many :blog_comments, dependent: :destroy

end