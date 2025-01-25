require_relative '../rails_helper'

RSpec.describe 'posts' do
  describe "GET /posts" do
    before do
      driven_by(:cuprite)
    end

    it 'should' do
      visit 'http://127.0.0.1/posts'
      expect(page).to have_http_status(:ok)
    end
  end
end
