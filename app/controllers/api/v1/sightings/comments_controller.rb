# frozen_string_literal: true

class Api::V1::Sightings::CommentsController < Api::V1::Sightings::BaseController
  skip_before_action :authenticate_api_user, only: [:index]
  before_action :set_comment, only: [:destroy]

  def index
    render json: @sighting.comments, each_serializer: CommentSerializer
  end

  def create
    @comment = Comment.new(comment_params.merge(sighting_id: @sighting.id))
    if @comment.save
      render json: @sighting.comments, each_serializer: CommentSerializer
    else
      render json: { error: @comment.errors.full_messages }, status: 400
    end
  end

  def destroy
    if @comment.owner?(current_user)
      @comment.destroy
      render json: @sighting.comments, each_serializer: CommentSerializer
    else
      render json: {
        error: 'You are not autherize to delete this comment'
        }, status: :unauthorized
    end
  end

  private

  def comment_params
    params.permit(:body).merge(user_id: current_user.id)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
