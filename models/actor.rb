class Actor < ActiveRecord::Base
  has_many :actor_movies
  has_many :movies, :through => :actor_movies
  def self.get_actors_info(actors_string)
    # imdb_data = HTTParty.get("http://www.omdbapi.com/?t=#{title}")
    # actors_string = imdb_data["Actors"]
    @actors = []
    actors_names = actors_string.split(",").map {|a| a.strip.chomp}
    actors_names.each do |name|
      @actors << Actor.create!(:name => name)
    end
    @actors
  end
end
