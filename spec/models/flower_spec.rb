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

require 'rails_helper'

RSpec.describe Flower, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
