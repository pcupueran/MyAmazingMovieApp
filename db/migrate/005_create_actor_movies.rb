class CreateActorMovies < ActiveRecord::Migration
  def self.up
    create_table :actor_movies do |t|
      t.integer :actor_id
      t.integer :movie_id
      t.timestamps
    end
  end

  def self.down
    drop_table :actor_movies
  end
end
