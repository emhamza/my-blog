require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.create(name: 'John Doe', posts_count: 0) }
  subject { described_class.new(title: 'Sample Post', author: user) }

  before { subject.save }

  it 'should have a title' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'should have an author' do
    subject.author = nil
    expect(subject).to_not be_valid
  end

  it 'title length should be between 1 and 250 characters' do
    subject.title = ''
    expect(subject).to_not be_valid

    subject.title = 'A' * 251
    expect(subject).to_not be_valid
  end

  it 'likes counter should not be less than 0' do
    subject.likes_counter = -1
    expect(subject).to_not be_valid
  end

  it 'comment counter should not be less than 0' do
    subject.comment_counter = -1
    expect(subject).to_not be_valid
  end

  describe 'scopes' do
    describe '.get_5_comments' do
      let!(:post) { Post.create(title: 'Sample Post', author: user) }
      let!(:recent_comments) { create_comments(post, 5, 1.day.ago) }
      let!(:older_comments) { create_comments(post, 3, 2.days.ago) }

      it 'returns the five most recent comments for the post' do
        expect(Post.get_5_comments(post)) == (recent_comments.reverse)
      end

      it 'limits the result to five comments' do
        expect(Post.get_5_comments(post).count) == (5)
      end
    end
  end

  # Helper method to create comments
  def create_comments(post, count, created_at)
    comments = []
    count.times do
      comments << Comment.create(post:, created_at:)
    end
    comments
  end
end
