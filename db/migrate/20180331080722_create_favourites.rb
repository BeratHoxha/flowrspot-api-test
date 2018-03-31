# frozen_string_literal: true

class CreateFavourites < ActiveRecord::Migration[5.1]
  def change
    create_table :favourites do |t|
      t.references :user, foreign_key: true
      t.references :flower, foreign_key: true

      t.timestamps
    end
  end
end
