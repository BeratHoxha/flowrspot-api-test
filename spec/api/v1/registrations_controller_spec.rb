# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::RegistrationsController, type: :controller do
  describe 'create' do
    context 'given inputs are valid' do
      it 'should return jwt token' do
        user_params = {
          email: 'user@example.com',
          password: 'password',
          first_name: 'Jack',
          last_name: 'Black',
          date_of_birth: DateTime.new(1980, 1, 1)
        }

        post :create, params: user_params
        expect(response.status).to eq(200)
        result = JSON.parse(response.body)
        expect(result['auth_token']).not_to be_nil
      end
    end

    context 'given inputs are invalid' do
      it 'should return error response' do
        user_params = {
          email: 'user@example.com',
          password: '',
          first_name: '',
          last_name: '',
          date_of_birth: nil
        }

        post :create, params: user_params
        expect(response.status).to eq(400)
        result = JSON.parse(response.body)
        expect(result['auth_token']).to be_nil
      end
    end
  end
end
