# frozen_string_literal: true

class FlowersSerializer < ActiveModel::Serializer
  attributes :id, :name, :latin_name
end
