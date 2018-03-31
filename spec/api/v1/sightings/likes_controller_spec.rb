# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Sightings::LikesController, type: :controller do
  let(:current_user) { create(:user, first_name: 'current', last_name: 'user') }
  let(:sighting) { create(:sighting, name: 'simple sighting') }
  describe 'GET #index' do
    it 'should return all likes of sighting' do
      user_1 = create(:user)
      user_2 = create(:user)
      create(:like, sighting: sighting, user: user_1)
      create(:like, sighting: sighting, user: user_2)

      get :index, params: { sighting_id: sighting.id }
      expect(response.status).to eq(200)

      results = JSON.parse(response.body)
      expect(results['likes'].count).to eq(2)
    end
  end

  describe 'create' do
    before(:each) do
      sign_in current_user
      @like_params = {
        sighting_id: sighting.id
      }
      post :create, params: @like_params
      @result = JSON.parse(response.body)
    end

    describe 'create succesfully' do
      before(:example) do
        @result = JSON.parse(response.body)
      end

      it 'should return status 200' do
        expect(response.status).to eq(200)
      end

      it 'like count should be 1' do
        expect(@result['likes'].count).to eq(1)
      end

      it 'user of like should be current_user' do
        expect(@result['likes'].map { |like| like['user']['id'] }).to include(current_user.id)
      end
    end

    describe 'create failure' do
      describe 'current_user can not like a same sighting again' do
        before(:example) do
          @comment_params = {
            sighting_id: sighting.id
          }
          post :create, params: @comment_params
          @result = JSON.parse(response.body)
        end

        it 'return duplicate like error' do
          expect(@result['error']).to eq('You can not like this sighting again')
        end
      end
    end
  end

  describe 'destroy' do
    before(:each) do
      sign_in current_user
      @other_user = create(:user, first_name: 'other user')
      @current_user_like = create(:like, sighting: sighting, user: current_user)
      @other_user_like = create(:like, sighting: sighting, user: @other_user)
    end

    describe 'delete succesfully' do
      before(:example) do
        @like_params = {
          sighting_id: sighting.id,
          id: @current_user_like
        }
        delete :destroy, params: @like_params
        @result = JSON.parse(response.body)
      end

      it 'should return status 200' do
        expect(response.status).to eq(200)
      end

      it 'return only comment of other_user_comment' do
        expect(@result['likes'].count).to eq(1)
      end
    end

    describe 'delete succesfully' do
      before(:example) do
        @like_params = {
          sighting_id: sighting.id,
          id: @other_user_like
        }
        delete :destroy, params: @like_params
        @result = JSON.parse(response.body)
      end

      it 'should return status 422' do
        expect(response.status).to eq(422)
      end

      it 'reutrn error message' do
        expect(@result['error']).to eq('You are not autherize to delete this like')
      end
    end
  end
end

def sign_in(user)
  request.headers['Authorization'] = user.to_jwt
end
