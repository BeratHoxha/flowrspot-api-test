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
        results = JSON.load(response.body)

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
        results = JSON.load(response.body)
        expect(results['flowers'].count).to eq(0)
      end
    end
  end

  describe 'search' do
    it 'should find the flower' do
      flower = create(:flower, name: 'Aronia')

      get :search, params: { query: 'aronia' }
      expect(response.status).to eq(200)
      results = JSON.load(response.body)
      expect(results['flowers'].count).to eq(1)
      expect(results['flowers'][0]['name']).to eq(flower.name)
    end

    it 'should return empty if no flower found' do
      flower = create(:flower, name: 'Aronia')

      get :search, params: { query: 'bethestha' }
      expect(response.status).to eq(200)
      results = JSON.load(response.body)
      expect(results['flowers'].count).to eq(0)
    end
  end

  describe 'show' do
    it 'should return a flower' do
      flower = create(:flower)
      get :show, params: { id: flower.id }
      expect(response.status).to eq(200)
      result = JSON.load(response.body)
      expect(result['flower']['id']).to eq(flower.id)
    end
  end

end
