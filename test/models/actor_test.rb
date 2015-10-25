require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe "Actor Model" do
  describe "get_actors method and save actors to the database" do
    it 'finds actors who belong to a movie and saves them in the database of actors ' do
      @actors = Actor.get_actors_info('Jaws')

      Actor.count.must_equal 4
      Actor.all.first.name.must_equal "Roy Scheider"
      Actor.all.fourth.name.must_equal "Lorraine Gary"

    end
  end

end
