# frozen_string_literal: true

# == Schema Information
#
# Table name: likes
#
#  id          :integer          not null, primary key
#  sighting_id :integer
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_likes_on_sighting_id  (sighting_id)
#  index_likes_on_user_id      (user_id)
#

class Like < ApplicationRecord
  belongs_to :user
  belongs_to :sighting

  validates_presence_of :user, :sighting

  def of?(current_user)
    user == current_user
  end
end
