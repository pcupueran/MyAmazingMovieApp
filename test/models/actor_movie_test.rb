require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe "ActorMovie Model" do
  it 'can construct a new instance' do
    @actor_movie = ActorMovie.new
    refute_nil @actor_movie
  end
end
