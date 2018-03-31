# frozen_string_literal: true

class CreateSightings < ActiveRecord::Migration[5.1]
  def change
    create_table :sightings do |t|
      t.integer :flower_id
      t.integer :user_id
      t.string :name
      t.text :description
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
    add_index :sightings, :flower_id
    add_index :sightings, :user_id
  end
end
