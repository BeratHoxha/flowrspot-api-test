# == Schema Information
#
# Table name: flowers
#
#  id                           :integer          not null, primary key
#  name                         :string
#  latin_name                   :string
#  features                     :string
#  description                  :text
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  profile_picture_file_name    :string
#  profile_picture_content_type :string
#  profile_picture_file_size    :integer
#  profile_picture_updated_at   :datetime
#  sightings_count              :integer          default(0)
#
# Indexes
#
#  index_flowers_on_sightings_count  (sightings_count)
#

class Flower < ApplicationRecord
  has_attached_file :profile_picture,
    styles: { medium: '300x300>', thumb: '100x100>' },
    default_url: '/images/:style/missing.png'
  validates_attachment_content_type :profile_picture,
    content_type: /\Aimage\/.*\z/

  validates :name, presence: true
  validates :latin_name, presence: true

  scope :alphabetical, ->() { order(:name) }

  has_many :sightings
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true
end
