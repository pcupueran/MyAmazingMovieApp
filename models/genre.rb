class Genre < ActiveRecord::Base

  def self.get_genres_info(genres_string)
    @genres = []
    genres_names = genres_string.split(",").map {|a| a.strip.chomp}
    genres_names.each do |name|
      @genres << Genre.find_or_create_by!(:name => name)
    end
    @genres
  end

end
