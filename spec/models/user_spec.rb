require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Umair Hamza', photo: 'link to photo', bio: 'Bio text here', posts_count: 0) }

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

  # describe '#three_recent_posts'  do
  #   let(:user) { create(:user) }

  #   it 'returns the three most recent posts' do
  #     user = User.create(name: 'name')
  #     first_post = Post.create(title: 'first_post', text: 'text', author_id: user.id)
  #     Post.create(title: 'second_post', text: 'text', author_id: user.id)
  #     Post.create(title: 'third_post', text: 'text', author_id: user.id)
  #     Post.create(title: 'fourth_post', text: 'text', author_id: user.id)
  #     expect(user.three_recent_posts).to_not include(first_post)
  #   end
  # end
end
