# frozen_string_literal: true

# == Schema Information
#
# Table name: comments
#
#  id          :integer          not null, primary key
#  body        :text
#  sighting_id :integer
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_comments_on_sighting_id  (sighting_id)
#  index_comments_on_user_id      (user_id)
#

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :sighting

  validates_presence_of :body, :user, :sighting

  def owner?(current_user)
    user == current_user
  end
end
