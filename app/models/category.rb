class Category < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 20 }
  validates :description, length: { maximum: 500 }

  has_many :posts
end
