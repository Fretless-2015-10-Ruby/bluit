class Post < ActiveRecord::Base
  validates :title, length: { maximum: 255 }, presence: true

  belongs_to :category
  default_scope { order(created_at: :desc) }

  # will_paginate configuration
  self.per_page = 4
end
