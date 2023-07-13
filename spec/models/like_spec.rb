require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user1) do
    User.create(
      name: 'Jill',
      photo: 'photo url here',
      bio: 'Bio text here',
      posts_count: 0
    )
  end

  let(:post1) do
    Post.create(
      author: user1,
      title: 'title-1',
      text: 'This is the text of my post',
      comment_counter: 0,
      likes_counter: 0
    )
  end

  subject { Like.create(post: post1, author: user1) }

  before { subject.save }

  it 'belongs to an author' do
    association = described_class.reflect_on_association(:author)
    expect(association.macro).to eq(:belongs_to)
  end

  it 'belongs to a post' do
    association = described_class.reflect_on_association(:post)
    expect(association.macro).to eq(:belongs_to)
  end

  it 'update likes counter of the post' do
    user1 = User.create(
      name: 'Jill',
      photo: 'photo url here',
      bio: 'Bio text here',
      posts_count: 0
    )
    post1 = Post.create(
      author: user1,
      title: 'title-1',
      text: 'This is the text of my post',
      comment_counter: 0,
      likes_counter: 0
    )
    Like.create(post: post1, author: user1)
    liked_post = Post.find_by_author_id(post1.author_id)
    expect(liked_post.likes_counter).to eq 1
  end
end
