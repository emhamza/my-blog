require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:hamza) { User.create(name: 'Umair Hamza', photo: 'photo link here', bio: 'Bio text here', posts_count: 0) }

  subject do
    Post.new(
      title: 'Five ways to learn Ruby',
      text: 'Ruby is a convention-based language',
      author: hamza
    )
  end

  before { subject.save }

  it 'should have a title' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'should have an author' do
    subject.author = nil
    expect(subject).to_not be_valid
  end

  it 'should not have a negative integer for the comments counter' do
    subject.comment_counter = -1
    expect(subject).to_not be_valid
  end

  it 'should not have a negative integer for the likes counter' do
    subject.likes_counter = -1
    expect(subject).to_not be_valid
  end
end
