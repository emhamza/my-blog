class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_save :update_likes_count

  private

  def update_likes_count
    post = Post.find_by_id(post_id)
    post.likes_counter = post.likes_counter.to_i + 1
    post.save
  end
end
