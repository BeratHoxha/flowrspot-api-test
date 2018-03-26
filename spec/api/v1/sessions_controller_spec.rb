require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :controller do

  describe 'create' do
    context 'given user exists' do
      it 'should return jwt token' do
        user = create(:user)

        user_params = {
          email: user.email,
          password: 'password'
        }

        post :create, params: user_params
        expect(response.status).to eq(200)
        result = JSON.load(response.body)
        expect(result['auth_token']).not_to be_nil
      end
    end

    context 'given user does not exists' do
      it 'should return error message' do
        user_params = {
          email: 'somebody@example.com',
          password: 'password'
        }

        post :create, params: user_params
        expect(response.status).to eq(400)
        result = JSON.load(response.body)
        expect(result['auth_token']).to be_nil
        expect(result['error']).to eq('Invalid email/password.')
      end
    end
  end
end
