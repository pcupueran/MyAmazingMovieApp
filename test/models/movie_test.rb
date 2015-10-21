require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe "Movie Model" do
  describe "get_film_info_method" do

    it "finds a movie on OMDB and saves the movie in the db and " do
      mock_data = JSON(File.read('test/jaws.json'))
      HTTParty.expects(:get).returns(mock_data)
      movie = Movie.get_film_info( 'Jaws')

      assert movie.is_a?(Movie)
      assert movie.persisted?

      Movie.count.must_equal 1
      movie.title.must_equal 'Jaws'
    end

  end
end
