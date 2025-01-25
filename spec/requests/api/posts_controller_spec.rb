RSpec.describe Api::PostsController, type: :request do
  describe "GET /index" do
    before do
      get "/api/posts"
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
  end
end