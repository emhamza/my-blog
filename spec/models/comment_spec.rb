require 'rails_helper'

RSpec.describe Comment, type: :model do
  @user1 = User.new(name: 'Tom', photo: 'url here', bio: 'bio text here')
  @user2 = User.new(name: 'Lilly', photo: 'url here', bio: 'bio text here')
  @post1 = Post.new(author: @user1, title: 'Hello', text: 'this is my first post')

  subject { Comment.create(post: @post1, author: @user2, text: 'Hi Tom!') }

  before { subject.save }

  it 'should have an text' do
    subject.text = nil
    expect(subject).to_not be_valid
  end

  it 'should have an author' do
    subject.author = nil
    expect(subject).to_not be_valid
  end

  it 'should have a post' do
    subject.post = nil
    expect(subject).to_not be_valid
  end

  it 'should belongs to an author' do
    comment = Comment.reflect_on_association('author')
    expect(comment.macro).to eq(:belongs_to)
  end

  it 'should belongs to an post' do
    comment = Comment.reflect_on_association('post')
    expect(comment.macro).to eq(:belongs_to)
  end

  it 'update comment counter for the post' do
    user1 = User.create(
      name: 'Tom',
      photo: 'url here',
      bio: 'bio text here',
      posts_count: 0
    )
    post1 = Post.create(author: user1, title: 'title-1', text: 'this is my first post', comment_counter: 0,
                        likes_counter: 0)
    Comment.create(post: post1, author: user1, text: 'Hi Tom!')
    commented_post = Post.find_by_author_id(post1.author_id)
    expect(commented_post.comment_counter).to eq 1
  end
end
