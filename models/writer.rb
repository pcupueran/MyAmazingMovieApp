class Writer < ActiveRecord::Base
  belongs_to :writer_movies

  def self.get_writers_info(writers_string)
    @writers = []
    writers_names = writers_string.split(",").map {|a| a.strip.chomp}
    writers_names.each do |name|
      @writers << Writer.find_or_create_by!(:name => name)
    end
    @writers
  end
end
