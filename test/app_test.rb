require File.expand_path(File.dirname(__FILE__) + '/test_config.rb')

describe "App" do

  describe "Session authentication" do
    it "do not allow access to movies if not authenticated" do
      get '/'
      last_response.ok?.must_equal false
      last_response.status.must_equal 401

    end

    it "GET to /login and display the page to login" do
      get '/login'
      last_response.ok?.must_equal true
      last_response.body.must_include "</form"
    end

    describe "POST to /login and submit the password to login" do
      it "does not authenticate if password is incorrect" do
        post MyAmazingMovieApp::App.url_for(:login, :password => "hello")

        follow_redirect!
        last_request.path.must_equal '/login'
      end
      it "does authenticate if password is correct and creates session(cookies)" do
        post '/login', {password: "cool_beans"}
        last_response.headers['Set-Cookie'].wont_equal nil
        follow_redirect!
        last_request.path.must_equal '/movies'
      end
    end

    describe "GET to /movies depending on cookies(session logged_in) and password" do
      before do
        @movie = Movie.get_film_info("District 9")
        post '/login', {password: "cool_beans"}
        assert last_response.redirect?              #request_method=POST
        last_response.headers['Set-Cookie'].wont_equal nil
        follow_redirect!                            #request_method=GET
        last_request.path.must_equal '/movies'

      end
      it "it shows movies if logged in and cookies are passed " do
        get '/movies'
        last_response.ok?.must_equal true
        last_response.body.must_include "<li>District 9</li>"
      end
    end
  end
end
