require 'rails_helper'

RSpec.describe 'User show method', type: :feature do
  before(:example) do
    @user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/man-person-standing-between-tall-trees-F_-0BxGuVvo',
                        bio: 'Teacher from Mexico', posts_count: 11)
    @posts = [Post.create(author: @user, title: 'Form in ROR',
                          text: 'Adding form to your ROR app increase credibility and better user experience',
                          likes_counter: 1, comment_counter: 1),
              Post.create(author: @user, title: 'Kurlus Osman',
                          text: 'This is a great Turkish series whose next series will be air
                          in the coming November only on air TV.',
                          likes_counter: 1, comment_counter: 0),
              Post.create(author: @user, title: 'Game of Throne',
                          text: 'The best series that I have watched so far',
                          likes_counter: 3, comment_counter: 2)]
    # Update the posts_count attribute based on the number of posts
    @user.update(posts_count: @posts.count)
  end

  it 'shows the users profile picture' do
    visit user_path(@user)
    expect(page).to have_css('img.img_container')
  end

  it 'shows the name of respective user' do
    visit user_path(@user)
    expect(page).to have_content(@user.name)
  end

  it 'shows the number of posts that the user has written' do
    visit user_path(@user)
    expect(page).to have_content("Number of posts: #{@user.posts_count}")
  end

  it 'shows the users bio' do
    visit user_path(@user)
    expect(page).to have_content(@user.bio)
  end

  it 'shows the users first three posts' do
    visit user_path(@user)
    @posts.each do |post|
      expect(page).to have_content(post.title)
    end
  end

  it 'shows the the see all post button' do
    visit user_path(@user)
    expect(page).to have_css('a.all_btn')
  end

  it 'redirect to the posts link' do
    visit user_path(@user)
    click_link('See all posts')
    expect(page).to have_current_path(user_posts_path(@user))
  end
end
