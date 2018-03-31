# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Sightings::CommentsController, type: :controller do
  let(:current_user) { create(:user, first_name: 'current', last_name: 'user') }
  let(:sighting) { create(:sighting, name: 'simple sighting') }

  describe 'get #index' do
    it 'should return comments of sighting from all users' do
      user_1 = create(:user, email: 'user1@example.com', first_name: 'user 1')
      user_2 = create(:user, email: 'user2@example.com', first_name: 'user 2')
      user_3 = create(:user, email: 'user3@example.com', first_name: 'user 3')
      comment_1 = create(:comment, sighting: sighting, user: user_1)
      comment_2 = create(:comment, sighting: sighting, user: user_2)
      comment_3 = create(:comment, sighting: sighting, user: user_3)

      get :index, params: { sighting_id: sighting.id }

      expect(response.status).to eq(200)
      results = JSON.parse(response.body)

      expect(results['comments'].count).to eq(3)
    end
  end

  describe 'POST #create' do
    before(:each) do
      sign_in current_user
    end

    describe 'create succesfully' do
      before(:example) do
        sign_in current_user
        @comment_params = {
          sighting_id: sighting.id,
          body: 'create a nice comment'
        }
        post :create, params: @comment_params
        @result = JSON.parse(response.body)
      end

      it 'should return status 200' do
        expect(response.status).to eq(200)
      end

      it 'comment params is equal with comment_params' do
        expect(@result['comments'][0]['comment']).to eq(@comment_params[:comment])
      end

      it 'user should heve user key' do
        expect(@result['comments'][0]).to have_key('user')
      end

      it 'comment of user should be from simple_user' do
        expect(@result['comments'][0]['user']['first_name']).to eq(current_user.first_name)
        expect(@result['comments'][0]['user']['last_name']).to eq(current_user.last_name)
      end
    end

    describe 'create failure' do
      describe 'when body of comment is nil' do
        before(:example) do
          @comment_params = {
            sighting_id: sighting.id
          }
          post :create, params: @comment_params
          @result = JSON.parse(response.body)
        end

        it 'return body error' do
          expect(@result['error'].first).to eq('Body can\'t be blank')
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    before(:each) do
      sign_in current_user
      @other_user = create(:user, first_name: 'other user')
      @other_user_comment = create(:comment, user: @other_user, sighting: sighting)
      @current_user_comment = create(:comment, user: current_user, sighting: sighting)
    end

    describe 'delete succesfully' do
      before(:example) do
        @comment_params = {
          sighting_id: sighting.id,
          id: @current_user_comment.id
        }
        delete :destroy, params: @comment_params
        @result = JSON.parse(response.body)
      end

      it 'should return status 200' do
        expect(response.status).to eq(200)
      end

      it 'return only comment of other_user_comment' do
        expect(@result['comments'].count).to eq(1)
      end
    end

    describe 'delete failure' do
      describe 'when user is not user of comment' do
        before(:example) do
          @comment_params = {
            sighting_id: sighting.id,
            id: @other_user_comment.id
          }
          delete :destroy, params: @comment_params
          @result = JSON.parse(response.body)
        end

        it 'should return status 401' do
          expect(response.status).to eq(401)
        end

        it 'reutrn error message' do
          expect(@result['error']).to eq('You are not autherize to delete this comment')
        end
      end
    end
  end
end

def sign_in(user)
  request.headers['Authorization'] = user.to_jwt
end
