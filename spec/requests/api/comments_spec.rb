require 'rails_helper'

RSpec.describe 'Api::Comments', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      # Manually create a user and post
      user = User.create(name: 'Test User', email: 'user@example.com')
      post = Post.create(title: 'Test Post', content: 'This is a test post.', user: user)

      # Use the appropriate IDs for the nested resources
      get "/api/users/#{user.id}/posts/#{post.id}/comments"

      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /create' do
    it 'returns http success' do
      # Manually create a user and post
      user = User.create(name: 'Test User', email: 'user@example.com')
      post = Post.create(title: 'Test Post', content: 'This is a test post.', user: user)

      # Use the appropriate IDs for the nested resources
      get "/api/users/#{user.id}/posts/#{post.id}/comments/create"

      expect(response).to have_http_status(:success)
    end
  end
end
