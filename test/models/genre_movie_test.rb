require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe "GenreMovie Model" do
  it 'can construct a new instance' do
    @genre_movie = GenreMovie.new
    refute_nil @genre_movie
  end
end
