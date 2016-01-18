require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe "Movie Model" do
  describe "get_film_info_method" do

    it "finds a movie on OMDB and saves the movie in the db" do
      mock_data = JSON(File.read('test/jaws.json'))
      HTTParty.expects(:get).returns(mock_data)
      movie = Movie.get_film_info( 'Jaws')

      assert movie.is_a?(Movie)
      assert movie.persisted?

      Movie.count.must_equal 1
      movie.title.must_equal 'Jaws'
    end

  end

  describe "Associations with other models" do

    before do
      @movie = Movie.get_film_info("Jaws")
    end

    it "has many actors through actor_movies" do
      Movie.all.first.actors.first.name.must_equal "Roy Scheider"
      Movie.all.first.actors.fourth.name.must_equal "Lorraine Gary"
    end

    it "has many directors through director_movies" do
      @movie.directors.first.name.must_equal "Steven Spielberg"
    end

    it "has many writers through writer_movies" do
      @movie.writers.first.name.must_equal "Peter Benchley (screenplay)"
      @movie.writers.second.name.must_equal "Carl Gottlieb (screenplay)"
    end

    it "has many genres through genre_movies" do
      @movie.genres.first.name.must_equal "Adventure"
      @movie.genres.second.name.must_equal "Drama"
    end

  end
end
