require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do

  describe 'show' do
    it 'should return user info' do
      user = create(:user)
      get :show, params: { id: user.id }
      expect(response.status).to eq(200)
      result = JSON.load(response.body)
      expect(result['user']['id']).to eq(user.id)
    end
  end

  describe 'update' do
    it 'should update the current user' do
      user = create(:user)

      user_params = {
        id: 'me',
        first_name: 'Mike'
      }

      request.headers['Authorization'] = user.to_jwt
      put :update, params: user_params
      expect(response.status).to eq(200)
      result = JSON.load(response.body)
      expect(result['user']['first_name']).to eq('Mike')
    end
  end

end
