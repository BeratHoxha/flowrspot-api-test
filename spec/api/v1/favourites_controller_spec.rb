# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::FavouritesController, type: :controller do
  let(:current_user) { create(:user, first_name: 'current', last_name: 'user') }
  describe 'index' do
    before(:each) do
      sign_in current_user
    end
    it 'should return 4 favorite flowers for user' do
      flowers = []
      %w[Dahlia Zinnia Ren Petunia].each_with_index do |name, index|
        flowers[index] = create(:flower, name: name)
      end
      0.upto(3) do |i|
        create(:favourite, flower_id: flowers[i].id, user_id: current_user.id)
      end

      get :index
      expect(response.status).to eq(200)

      results = JSON.parse(response.body)

      expect(results['flowers'].count).to eq(4)

      0.upto(3) do |i|
        compare_results(results['flowers'][i]['name'], flowers[i].name)
      end
    end

    it 'should return empty list of favorite flowers for user' do
      get :index
      expect(response.status).to eq(200)

      results = JSON.parse(response.body)

      expect(results['flowers'].count).to eq(0)
    end
  end

  def compare_results(expected_result, actual_result)
    expect(expected_result).to eq(actual_result)
  end

  def sign_in(user)
    request.headers['Authorization'] = user.to_jwt
  end
end
