class AddProfilePictureToFlowers < ActiveRecord::Migration[5.1]
  def change
    add_attachment :flowers, :profile_picture
  end
end
