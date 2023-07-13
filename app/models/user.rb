class User < ApplicationRecord
  has_many :posts, foreign_key: :auhtor_id
  has_many :comments, foreign_key: :auhtor_id
  has_many :likes, foreign_key: :auhtor_id
  has_many :liked_posts, through: :likes, source: :post
  has_many :commented_posts, through: :comments, source: :post
end
