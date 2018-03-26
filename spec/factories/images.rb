# == Schema Information
#
# Table name: images
#
#  id          :integer          not null, primary key
#  flower_id   :integer
#  sighting_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_images_on_flower_id    (flower_id)
#  index_images_on_sighting_id  (sighting_id)
#

FactoryGirl.define do
  factory :image do
    flower_id 1
    sighting_id 1
  end
end
