class CreateGenreMovies < ActiveRecord::Migration
  def self.up
    create_table :genre_movies do |t|
      t.integer :movie_id
      t.integer :genre_id
      t.timestamps
    end
  end

  def self.down
    drop_table :genre_movies
  end
end
