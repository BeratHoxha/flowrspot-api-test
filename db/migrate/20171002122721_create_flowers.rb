class CreateFlowers < ActiveRecord::Migration[5.1]
  def change
    create_table :flowers do |t|
      t.string :name
      t.string :latin_name
      t.string :features
      t.text :description

      t.timestamps
    end
  end
end
