# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::FlowersController, type: :controller do
  describe 'index' do
    context 'given i have some flowers' do
      it 'should return flowers in alphabetical order' do
        flower_1 = create(:flower, name: 'Betty')
        flower_2 = create(:flower, name: 'Aronia')
        flower_3 = create(:flower, name: 'Cecilia')

        get :index
        expect(response.status).to eq(200)
        results = JSON.parse(response.body)

        expect(results['flowers'].count).to eq(3)
        expect(results['flowers'][0]['name']).to eq(flower_2.name)
        expect(results['flowers'][1]['name']).to eq(flower_1.name)
        expect(results['flowers'][2]['name']).to eq(flower_3.name)
      end
    end

    context 'given i have no flowers' do
      it 'should return empty array' do
        get :index
        expect(response.status).to eq(200)
        results = JSON.parse(response.body)
        expect(results['flowers'].count).to eq(0)
      end
    end
  end

  describe 'search' do
    it 'should find the flower' do
      flower = create(:flower, name: 'Aronia')

      get :search, params: { query: 'aronia' }
      expect(response.status).to eq(200)
      results = JSON.parse(response.body)
      expect(results['flowers'].count).to eq(1)
      expect(results['flowers'][0]['name']).to eq(flower.name)
    end

    it 'should return empty if no flower found' do
      flower = create(:flower, name: 'Aronia')

      get :search, params: { query: 'bethestha' }
      expect(response.status).to eq(200)
      results = JSON.parse(response.body)
      expect(results['flowers'].count).to eq(0)
    end
  end

  describe 'show' do
    it 'should return a flower' do
      flower = create(:flower)
      get :show, params: { id: flower.id }
      expect(response.status).to eq(200)
      result = JSON.parse(response.body)
      expect(result['flowers']['id']).to eq(flower.id)
    end
  end

  describe 'create' do
    it 'should create a flower' do
      flower = create(:flower)
      post :create, params: flower_params(flower)

      result = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(result['flower']['name']).to eq('A flower')
      expect(result['flower']['latin_name']).to eq('Latin name')
    end

    it 'should not create a flower when name is missing' do
      flower = create(:flower)
      flower.name = nil
      post :create, params: flower_params(flower)

      expect(response.status).to eq(400)
      expect(JSON.parse(response.body)['error'][0]).to eq('Name can\'t be blank')
    end

    it 'should not create a flower when latin_name is missing' do
      flower = create(:flower)
      flower.latin_name = nil

      post :create, params: flower_params(flower)
      expect(response.status).to eq(400)
      expect(JSON.parse(response.body)['error'][0]).to eq('Latin name can\'t be blank')
    end
  end

  def flower_params(flower)
    {
      name: flower.name,
      latin_name: flower.latin_name,
      features: flower.features,
      description: flower.description
    }
  end
end
