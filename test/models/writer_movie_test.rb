require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe "WriterMovie Model" do
  it 'can construct a new instance' do
    @writer_movie = WriterMovie.new
    refute_nil @writer_movie
  end
end
