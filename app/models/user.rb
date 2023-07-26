class User < ApplicationRecord
  before_validation :set_default
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :posts, foreign_key: :author_id
  has_many :comments, foreign_key: :author_id
  has_many :likes, foreign_key: :author_id
  has_many :liked_posts, through: :likes, source: :post
  has_many :commented_posts, through: :comments, source: :post

  scope :three_recent_posts, ->(user) { user.posts.order(created_at: :desc).limit(3) }

  validates :name, presence: true
  validates :posts_count, numericality: { only_integer: true }, comparison: { greater_than_or_equal_to: 0 }

  # def set_default
  #   self.name = email.split('@')[0]
  #   self.posts_count = 0
  # end
end
