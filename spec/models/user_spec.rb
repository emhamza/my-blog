require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Umair Hamza', photo: 'link to photo', bio: 'Bio text here', posts_count: 0) }

  before { subject.save }

  it 'should have a name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'posts count shout not be less than or equal to 0' do
    subject.posts_count = -1
    expect(subject).to_not be_valid
  end

  it 'should not allow non-integer value' do
    subject.posts_count = 'abc'
    expect(subject).to_not be_valid
  end
end
