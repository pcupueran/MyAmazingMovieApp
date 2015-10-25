class Movie < ActiveRecord::Base
  has_many :actor_movies
  has_many :director_movies
  has_many :actors, :through => :actor_movies
  has_many :directors, :through => :director_movies
  before_save :set_slug

  def self.get_film_info(title)
    imdb_data = HTTParty.get("http://www.omdbapi.com/?t=#{title}")
    m = Movie.new(title: imdb_data["Title"])
    m.year = imdb_data["Year"]
    m.description = imdb_data["Plot"]
    m.poster = imdb_data["Poster"]
    m.runtime = imdb_data["Runtime"]

    actors = Actor.get_actors_info(imdb_data["Actors"])
    directors = Director.get_directors_info(imdb_data["Director"])

    actors.each { |actor| m.actors << actor }
    directors.each { |director| m.directors << director}
    m.save!
    m
  end

  protected
  def set_slug
    self.slug = title.chomp.strip.downcase.gsub(" ", "-")
  end
end
