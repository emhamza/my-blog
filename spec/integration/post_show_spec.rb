require 'rails_helper'

RSpec.describe 'Post show method', type: :feature do
  before(:example) do
    @user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/man-person-standing-between-tall-trees-F_-0BxGuVvo',
                        bio: 'Teacher from Mexico', posts_count: 11)
    @posts = [Post.create(author: @user, title: 'Form in ROR',
                          text: 'Adding form to your ROR app increase credibility and better user experience',
                          likes_counter: 1, comment_counter: 1),
              Post.create(author: @user, title: 'Kurlus Osman',
                          text: 'This is a great Turkish series whose next series will be air in the coming November only on air TV.',
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

  it 'shows a post title' do
    visit user_posts_path(@user, @posts)
    @posts.each do |post|
      expect(page).to have_content(post.title)
    end
  end

  it 'should shows the post author' do
    visit user_posts_path(@user, @posts)
    expect(page).to have_content(@user.name)
  end

  it 'should shows how many comment post has' do
    visit user_posts_path(@user, @posts)
    expect(page).to have_content(@posts[0].comment_counter)
  end

  it 'should shows how many Likes post has' do
    visit user_posts_path(@user, @posts)
    expect(page).to have_content(@posts[0].likes_counter)
  end

  it 'should shows the text of a post' do
    visit user_posts_path(@user, @posts)
    @posts.each do |post|
      expect(page).to have_content(post.text)
    end
  end

  it 'should shows the comment author' do
    visit user_posts_path(@user, @posts)
    @comments.each do |comment|
      expect(page).to have_content(comment.author.name)
    end
  end

  it 'should shows the comment text' do
    visit user_posts_path(@user, @posts)
    @comments.each do |comment|
      expect(page).to have_content(comment.text)
    end
  end
end
