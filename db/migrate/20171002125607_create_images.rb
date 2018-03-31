# frozen_string_literal: true

class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.integer :flower_id
      t.integer :sighting_id

      t.timestamps
    end
    add_index :images, :flower_id
    add_index :images, :sighting_id
  end
end
