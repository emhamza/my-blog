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
    author.increment!(:posts_count)
  end
end
