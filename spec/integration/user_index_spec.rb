require 'rails_helper'

RSpec.describe 'User Index Page', type: :feature do
    #Integration test scenarios will go here
    before(:example) do
        @users = [
            User.create(name: 'Tom', photo: 'user-img url', bio: 'Teacher from Mexico.' , posts_count: 11 ),
            User.create(name: 'Lilly', photo: 'user-img url', bio: 'Teacher from Poland.' , posts_count: 17 )
        ]
        visit root_path
    end

    it 'display the username of all other users' do
        @users.each do |user|
            expect(page).to have_content(user.name)
        end
    end

    it 'shows the number of posts each user has' do
        @users.each do |user|
            expect(page).to have_content("Number of posts: #{user.posts_count}")
        end
    end
    it 'can redirect to the user-show page when clicked on user-name' do
        @users.each do |user|
            click_link user.name
            expect(current_path).to eq(user_path(user))
          end
    end
end