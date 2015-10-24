require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')
require_relative '../../../app/app'

describe "GET to /movies/jaws" do
  describe "with a movie in the db" do
    before do
      Movie.create(:title => "Jaws")
      get "/movies/jaws"
    end

    it "should display info about Jaws" do
      assert last_response.ok?
      last_response.headers['Content-Type'].must_equal 'text/html;charset=utf-8'
      last_response.body.must_match "Jaws"
    end
  end

  describe "without a movie in the db" do
    before do
      get '/movies/jaws'
    end

    it "should 404" do
      assert last_response.not_found?
    end
  end
end

describe "GET to /movies"do
  before do
    Movie.create!(:title => 'Jaws')
    get '/movies'
  end

  it "should display all of the films" do
    assert last_response.ok?
    last_response.headers['Content-Type'].must_equal 'text/html;charset=utf-8'
    last_response.body.must_match "<li>Jaws</li>"
  end
end

describe "Editing a movie GET to /movies/:id/edit" do
  before do
    @movie = Movie.create!(:title => 'Jaws')
    get "/movies/#{@movie.id}/edit"
  end

  it "should display a form for me to edit my movie" do
    assert last_response.ok?
    last_response.headers['Content-Type'].must_equal 'text/html;charset=utf-8'
    last_response.body.must_match "</form>"
  end
end

describe "Submiting my changes POST to /movies/:id/update"do
  before do
    @movie = Movie.create!(:title => "Jaws")
    post "/movies/#{@movie.id}/update", {movie: {title: 'Jaws 2'}}
    # post MyAmazingMovieApp::App.url_for(:movies, :update, id: @movie.id), {movie: {title: 'Jaws 2'}}
  end

  it "should update the movie" do
    Movie.count.must_equal 1
    @movie.reload.title.must_equal 'Jaws 2'
  end
end

describe "Creating a movie" do

  describe "GET to /movies/new" do
    it "should display the form for a new movie" do
      get "/movies/new"

      assert last_response.ok?
       last_response.body.must_match "</form>"
    end
  end

  describe "POST to /movies/create" do
    it "should take the form submission and creates a new movie in the db" do
      post '/movies/create', {movie: {title: "Avatar"}}
      Movie.count.must_equal 1
      assert_equal 1, Movie.where(title: "Avatar").length
    end
  end
end

describe "Deleting a movie" do
  before do
    @movie = Movie.create!(:title => 'Avatar')
    @movie_2 = Movie.create!(:title => 'Back to the future')
    post "/movies/#{@movie.id}/delete"
  end

  it "should delete a movie " do
    assert last_response.ok?
    Movie.count.must_equal 1
  end
end


#TODO: Write unit test for creating a Movie:
#1.Create a controller action that displays the form for a new movie
#2. Create a controller action that takes the form submission and creates
#the movie in the databse.
#3.Create a controller action that deletes a movie.
