class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  validates :text, presence: true

  after_save :update_comment_counter

  private

  def update_comment_counter
    post = Post.find_by_id(post_id)
    post.comment_counter = post.comment_counter.to_i + 1
    post.save
  end
end
