class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :likes, foreign_key: :post_id
  has_many :comments, foreign_key: :post_id

  after_save :update_post_counter

  scope :get_5_comments, ->(post) { post.comments.order('created_at desc').limit(5) }

  validates :title, presence: true
  validates :author, presence: true
  validates :title, length: { in: 1..250 }
  validates :likes_counter, numericality: { only_integer: true }, comparison: { greater_than_or_equal_to: 0 }
  validates :comment_counter, numericality: { only_integer: true }, comparison: { greater_than_or_equal_to: 0 }

  private

  def update_post_counter
    poster = User.find_by_id(author.id)
    poster.posts_count = poster.posts_count.to_i + 1
    poster.save
  end
end
