class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :likes, foreign_key: :post_id
  has_many :comments, foreign_key: :post_id

  after_save :update_post_counter

  scope :get_5_comments, ->(post) { post.comments.order('created_at desc').limit(5) }

  private

  def update_post_counter
    poster = User.find_by_id(author.id)
    poster.posts_count = poster.posts_count.to_i + 1
    poster.save
  end
end
