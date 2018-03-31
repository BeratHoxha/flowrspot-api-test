# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Users::SightingsController, type: :controller do
  describe 'index' do
    it 'should return only users sightings' do
      user = create(:user)
      sightings = []

      0.upto(3) do |i|
        sightings[i] = create(:sighting, user: user)
      end

      get :index, params: { id: user.id }

      assert response
    end

    it 'should return empty list for non existing user' do
      get :index, params: { id: 1 }

      expect(response.status).to eq(404)
      expect(JSON.parse(response.body)['error']).to eq("Couldn't find User with 'id'=1")
    end
  end

  def assert(expected_response)
    expect(expected_response.status).to eq(200)
    results = JSON.load(expected_response.body)
    expect(results['sightings'].count).to eq(4)
  end
end
