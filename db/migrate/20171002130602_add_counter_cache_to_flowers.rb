# frozen_string_literal: true

class AddCounterCacheToFlowers < ActiveRecord::Migration[5.1]
  def change
    add_column :flowers, :sightings_count, :integer, default: 0, nullable: false
    add_index :flowers, :sightings_count
  end
end
