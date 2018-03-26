class AddProfilePictureToUsers < ActiveRecord::Migration[5.1]
  def change
    add_attachment :users, :profile_picture
  end
end
