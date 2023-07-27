require 'rails_helper'

RSpec.describe 'Api::Posts', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      # Assuming you have some posts in the database
      # Create posts for testing
      post1 = Post.create(title: 'Post 1', text: 'This is the first post.')
      post2 = Post.create(title: 'Post 2', text: 'This is the second post.')

      # Make the API request
      get '/api/posts/index'

      # Expect a successful response
      expect(response).to have_http_status(:success)

      # Parse the JSON response
      posts = JSON.parse(response.body)

      # Expect the correct number of posts in the response
      expect(posts.length).to eq(2)

      # Expect the response to contain the correct post attributes
      expect(posts[0]['title']).to eq(post1.title)
      expect(posts[0]['text']).to eq(post1.text)
      expect(posts[1]['title']).to eq(post2.title)
      expect(posts[1]['text']).to eq(post2.text)
    end
  end
end
