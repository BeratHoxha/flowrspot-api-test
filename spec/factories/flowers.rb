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

FactoryGirl.define do
  factory :flower do
    name { Faker::Name.name }
    latin_name { Faker::Lorem.word }
    features { ["it's a flower"] }
    description { 'Has blue leafs.' }
  end
end
