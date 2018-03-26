class AddPictureToSightings < ActiveRecord::Migration[5.1]
  def change
    add_attachment :sightings, :picture
  end
end
