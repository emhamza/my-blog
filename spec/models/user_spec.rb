require 'rails_helper'

RSpec.describe User, type: :model do
  subject { described_class.new(name: 'Umair Hamza', photo: 'link to photo', bio: 'Bio text here', posts_count: 0) }

  before { subject.save }

  it 'should have a name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'posts count should not be less than or equal to 0' do
    subject.posts_count = -1
    expect(subject).to_not be_valid
  end

  it 'should not allow non-integer value' do
    subject.posts_count = 'abc'
    expect(subject).to_not be_valid
  end

  describe 'scopes' do
    describe '.three_recent_posts' do
      let(:user) { described_class.create(name: 'John Doe', posts_count: 0) }
      let!(:recent_post) { Post.create(author: user, created_at: 1.day.ago) }
      let!(:older_post1) { Post.create(author: user, created_at: 2.days.ago) }
      let!(:older_post2) { Post.create(author: user, created_at: 3.days.ago) }
      let!(:another_user_post) { Post.create(created_at: 1.day.ago) }

      it 'returns the three most recent posts by the user' do
        expect(User.three_recent_posts(user)) == ([recent_post, older_post1, older_post2])
      end

      it 'does not include posts by other users' do
        expect(User.three_recent_posts(user)).not_to include(another_user_post)
      end

      it 'limits the result to three posts' do
        expect(User.three_recent_posts(user).count) == (3)
      end
    end
  end
end
