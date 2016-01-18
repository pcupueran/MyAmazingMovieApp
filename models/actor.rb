class Actor < ActiveRecord::Base
  has_many :actor_movies
  has_many :movies, :through => :actor_movies

  def self.get_actors_info(actors_string)
    @actors = []
    actors_names = actors_string.split(",").map {|a| a.strip.chomp}
    actors_names.each do |name|
      @actors << Actor.find_or_create_by!(:name => name)
    end
    @actors
  end
end
