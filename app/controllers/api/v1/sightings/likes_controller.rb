# frozen_string_literal: true

class Api::V1::Sightings::LikesController < Api::V1::Sightings::BaseController
  skip_before_action :authenticate_api_user, only: [:index]
  def index
    render json: @sighting.likes, each_serializer: LikeSerializer
  end

  def create
    if @sighting.like?(current_user)
      render json: { error: 'You can not like this sighting again' }, status: 422
    else
      @sighting.likes.create(user: current_user)
      render json: @sighting.likes, each_serializer: LikeSerializer
    end
  end

  def destroy
    @like = Like.find(params[:id])
    if @like.of?(current_user)
      @like.destroy
      render json: @sighting.likes, each_serializer: LikeSerializer
    else
      render json: { error: 'You are not autherize to delete this like' }, status: 422
    end
  end
end
