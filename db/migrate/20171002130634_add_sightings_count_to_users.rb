class AddSightingsCountToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :sightings_count, :integer, default: 0, nullable: false
    add_index :users, :sightings_count
  end
end
