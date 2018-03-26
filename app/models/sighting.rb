# == Schema Information
#
# Table name: sightings
#
#  id                   :integer          not null, primary key
#  flower_id            :integer
#  user_id              :integer
#  name                 :string
#  description          :text
#  latitude             :float
#  longitude            :float
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  picture_file_name    :string
#  picture_content_type :string
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#
# Indexes
#
#  index_sightings_on_flower_id  (flower_id)
#  index_sightings_on_user_id    (user_id)
#

class Sighting < ApplicationRecord
  belongs_to :user, counter_cache: true
  belongs_to :flower, counter_cache: true

  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true

  validates :user, presence: true
  validates :flower, presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true

  has_attached_file :picture,
    styles: { medium: '300x300>', thumb: '100x100>' },
    default_url: '/images/:style/missing.png'
  validates_attachment_content_type :picture,
    content_type: /\Aimage\/.*\z/
end
