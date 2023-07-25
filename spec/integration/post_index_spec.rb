require 'rails_helper'

RSpec.describe 'User show method', type: :feature do
  before(:example) do
    @user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/man-person-standing-between-tall-trees-F_-0BxGuVvo',
                        bio: 'Teacher from Mexico', posts_count: 11)
    @posts = [Post.create(author: @user, title: 'Form in ROR',
                          text: 'Adding form to your ROR app increase credibility
                          and better user experience',
                          likes_counter: 1, comment_counter: 1),
              Post.create(author: @user, title: 'Kurlus Osman',
                          text: 'This is a great Turkish series whose next series will be air in
                           the coming November only on air TV.',
                          likes_counter: 1, comment_counter: 0),
              Post.create(author: @user, title: 'Game of Throne',
                          text: 'The best series that I have watched so far',
                          likes_counter: 3, comment_counter: 2)]
    @comments = [
      Comment.create(author: @user, post: @posts[0], text: 'Very informatic'),
      Comment.create(author: @user, post: @posts[0], text: 'Informatic'),
      Comment.create(author: @user, post: @posts[2], text: 'Very informatic')
    ]
    # Update the posts_count attribute based on the number of posts
    @user.update(posts_count: @posts.count)
  end

  it 'shows the users profile picture' do
    visit user_posts_path(@user, @posts)
    expect(page).to have_css('img.img_container')
  end

  it 'shows the name of respective user' do
    visit user_posts_path(@user, @posts)
    expect(page).to have_content(@user.name)
  end

  it 'shows the number of posts that the user has written' do
    visit user_posts_path(@user, @posts)
    expect(page).to have_content("Number of posts: #{@user.posts_count}")
  end

  it 'shows the post title' do
    visit user_posts_path(@user, @posts)
    @posts.each do |post|
      expect(page).to have_content(post.title)
    end
  end

  it 'shows the post text' do
    visit user_posts_path(@user, @posts)
    @posts.each do |post|
      expect(page).to have_content(post.text)
    end
  end

  it 'shows a post recent comments' do
    visit user_posts_path(@user, @posts)
    Post.get_5_comments(@posts[0]).each do |comment|
      expect(page).to have_content(comment.text)
    end
  end

  it 'should shows a comment counter' do
    visit user_posts_path(@user, @posts)
    expect(page).to have_content(@posts[0].comment_counter)
  end

  it 'should shows a Likes counter' do
    visit user_posts_path(@user, @posts)
    expect(page).to have_content(@posts[0].likes_counter)
  end

  it 'should shows a Pagination' do
    visit user_posts_path(@user, @posts)
    expect(page).to have_content('Pagination')
  end

  it 'should redirect me to the post page' do
    visit user_posts_path(@user, @posts)
    click_link(@posts[0].title)
    expect(page).to have_current_path(post_path(@user, @posts[0]))
  end
end
