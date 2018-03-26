require 'rails_helper'

RSpec.describe Api::V1::SightingsController, type: :controller do

  describe 'index' do
    it 'should return latest sightings' do
      user = create(:user)
      flower = create(:flower)
      sighting = create(:sighting, user: user, flower: flower)
      sighting_2 = create(:sighting, flower: flower)

      get :index
      expect(response.status).to eq(200)
      results = JSON.load(response.body)
      expect(results['sightings'].count).to eq(2)
    end
  end

  describe 'show' do
    it 'should return a sighting' do
      user = create(:user)
      flower = create(:flower)
      sighting = create(:sighting, user: user, flower: flower)

      get :show, params: { id: sighting.id }
      expect(response.status).to eq(200)
      result = JSON.load(response.body)
      expect(result['sighting']['id']).to eq(sighting.id)
    end
  end

  describe 'create' do
    it 'should create a sighting' do
      user = create(:user)
      flower = create(:flower)

      sighting_params = {
        flower_id: flower.id,
        name: 'Apix',
        description: 'Mijav',
        latitude: 14.213131,
        longitude: 15.12313
      }

      request.headers['Authorization'] = user.to_jwt
      post :create, params: sighting_params
      expect(response.status).to eq(200)
      result = JSON.load(response.body)
      expect(result['sighting']['name']).to eq(sighting_params[:name])
    end
  end

  describe 'update' do
    it 'should update the sighting' do
      user = create(:user)
      flower = create(:flower)
      sighting = create(:sighting, user: user, flower: flower)

      sighting_params = {
        id: sighting.id,
        flower_id: flower.id,
        name: 'Apix',
        description: 'Mijav',
        latitude: 14.213131,
        longitude: 15.12313
      }

      request.headers['Authorization'] = user.to_jwt
      put :update, params: sighting_params
      expect(response.status).to eq(200)
      result = JSON.load(response.body)
      expect(result['sighting']['name']).to eq('Apix')
    end

    it 'should return 400 if sighting not found' do
      user = create(:user)
      flower = create(:flower)
      sighting = create(:sighting)

      sighting_params = {
        id: sighting.id,
        flower_id: flower.id,
        name: 'Apix',
        description: 'Mijav',
        latitude: 14.213131,
        longitude: 15.12313
      }

      request.headers['Authorization'] = user.to_jwt
      put :update, params: sighting_params
      expect(response.status).to eq(404)
    end
  end

  describe 'destroy' do
    it 'should destroy the sighting' do
      sighting = create(:sighting)
      user = sighting.user

      request.headers['Authorization'] = user.to_jwt
      delete :destroy, params: { id: sighting.id }
      expect(response.status).to eq(200)
    end
  end

end
