require 'capybara/rspec'
Capybara.configure do |config|
  # Set the default driver to Selenium for browser-based testing
  config.default_driver = :selenium_chrome
end

# Capybara.app_host = 'http://127.0.0.1:3000'

RSpec.describe 'books page', type: :system do
  describe "GET /" do
    before(:all) do
      driven_by :cuprite
      # Start the Next.js app using `serve` before any tests are run
      @server_pid = fork do
        # Run the static server in the background
        exec("ruby -rwebrick -e'WEBrick::HTTPServer.new(Port: 8000, DocumentRoot: \"/Users/anton.i/projects/ararat/dist\").start'")
      end
      puts "PID: #{@server_pid}"
      # Give the server a moment to start
      sleep 2
    end

    after(:all) do
      # Stop the server after tests finish
      Process.kill("TERM", @server_pid) if @server_pid
      Process.wait(@server_pid)
    end

    before do
      # visit "http://127.0.0.1:8000/"
      visit '/api/books/'
    end

    it "returns http success" do
      # expect(response).to have_http_status(:success)
      save_and_open_screenshot
    end
  end
end
