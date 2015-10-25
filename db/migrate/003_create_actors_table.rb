class CreateActorsTable < ActiveRecord::Migration
  def self.up
    create_table :actors
  end

  def self.down
    delete_table :actors
  end
end
