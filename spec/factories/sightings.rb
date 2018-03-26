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

FactoryGirl.define do
  factory :sighting do
    name { Faker::Name.name }
    user { create(:user) }
    flower { create(:flower) }
    description { 'Under the rainbox.'}
    latitude { 14.0 }
    longitude { 5.123456 }
  end
end
