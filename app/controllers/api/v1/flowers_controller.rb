# frozen_string_literal: true

class Api::V1::FlowersController < Api::V1::BaseController
  skip_before_action :authenticate_api_user

  def index
    @flowers = Flower.alphabetical.page(params[:page]).per(params[:per_page])
    render json: @flowers,
           root: :flowers,
           meta: generate_pagination(@flowers),
           each_serializer: FlowersSerializer
  end

  def search
    @flowers = Flower.alphabetical
                     .where(
                       'name iLIKE :query OR latin_name iLIKE :query',
                       query: "%#{params[:query]}"
                     )
                     .page(params[:page])
                     .per(params[:per_page])
    render json: @flowers,
           root: :flowers,
           meta: generate_pagination(@flowers),
           each_serializer: FlowersSerializer
  end

  def create
    @flower = build_flower

    if @flower.save
      render json: @flower,
             root: :flower,
             each_serializer: FlowersSerializer
    else
      render json: { error: @flower.errors.full_messages },
             status: :bad_request
    end
  end

  def show
    @flower = Flower.find params[:flower_id] || params[:id]
    render json: @flower,
           root: :flowers,
           meta: generate_pagination(@flower),
           each_serializer: FlowersSerializer
  end

  private

  def build_flower
    Flower.new(flower_params)
  end

  def flower_params
    params.permit(:name, :latin_name, :features, :description, :profile_picture)
  end
end
