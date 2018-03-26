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

class Image < ApplicationRecord
  belongs_to :flower, optional: true
  belongs_to :sighting, optional: true

  has_attached_file :picture,
    styles: { medium: '300x300>', thumb: '100x100>' },
    default_url: '/images/:style/missing.png'
  validates_attachment_content_type :picture,
    content_type: /\Aimage\/.*\z/
end
