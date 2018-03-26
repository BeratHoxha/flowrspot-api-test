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

class FlowerSerializer < ActiveModel::Serializer
  attributes :id, :name, :latin_name
end
