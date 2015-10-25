require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe "DirectorMovie Model" do
  it 'can construct a new instance' do
    @director_movie = DirectorMovie.new
    refute_nil @director_movie
  end
end
