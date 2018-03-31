# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Flowers::FavouritesController, type: :controller do
  let(:current_user) { create(:user, first_name: 'current', last_name: 'user') }

  describe 'create' do
    before(:each) do
      sign_in current_user
    end

    it 'should favourite new flowers' do
      first_flower = create(:flower)
      second_flower = create(:flower)

      post :create, params: favourite_params(current_user, first_flower)
      post :create, params: favourite_params(current_user, second_flower)

      expect(response.status).to eq(200)

      results = JSON.load(response.body)

      expect(results['flowers'].first['id']).to eq(first_flower.id)
      expect(results['flowers'].first['name']).to eq(first_flower.name)
      expect(results['flowers'].first['latin_name']).to eq(first_flower.latin_name)

      expect(results['flowers'].second['id']).to eq(second_flower.id)
      expect(results['flowers'].second['name']).to eq(second_flower.name)
      expect(results['flowers'].second['latin_name']).to eq(second_flower.latin_name)
    end
  end

  def favourite_params(user, flower)
    {
      user_id: user.id,
      flower_id: flower.id
    }
  end

  def sign_in(user)
    request.headers['Authorization'] = user.to_jwt
  end
end
