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

class CommentSerializer < ActiveModel::Serializer
  attributes :id, :body
  belongs_to :user, serializer: UserSerializer
end
