class Director < ActiveRecord::Base
  belongs_to :movie

  def self.get_directors_info(directors_string)
    @directors = []
    directors_names = directors_string.split(",").map {|a| a.strip.chomp}
    directors_names.each do |name|
      @directors << Director.find_or_create_by!(:name => name)
    end
    @directors
  end
end
