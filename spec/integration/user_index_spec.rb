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

    it 'displays the profile picture for each user' do
        # Test code for this scenario
        @users.each do |user|
            expect(page).to have_selector("img[src='#{user.photo}']")
        end
    end

    it 'can redirect to the user-show page when clicked on user-name' do
        click_link(@users.first.name)
        expect(page).to have_current_path(user_path(@users.first))
    end
end