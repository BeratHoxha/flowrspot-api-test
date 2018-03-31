# frozen_string_literal: true

class Api::V1::SightingsController < Api::V1::BaseController
  skip_before_action :authenticate_api_user, only: %i[index show]

  def index
    @sightings = Sighting.includes(:user).page(params[:page]).per(params[:per_page])
    render json: @sightings,
           root: :sightings,
           meta: generate_pagination(@sightings),
           each_serializer: SightingsSerializer
  end

  def show
    @sighting = Sighting.find params[:id]
    render json: @sighting, serializer: SightingSerializer
  end

  def create
    @sighting = Sighting.new(sighting_params)
    @sighting.user_id = @current_user.id

    if @sighting.save
      render json: @sighting, serializer: SightingSerializer
    else
      render json: { error: @sighting.errors.full_messages },
             status: 400
    end
  end

  def update
    @sighting = Sighting.find params[:id]
    if @sighting.update(sighting_params)
      render json: @sighting, serializer: SightingSerializer
    else
      render json: { error: @sighting.errors.full_messages },
             status: 400
    end
  end

  def destroy
    @sighting = Sighting.find params[:id]
    render json: @sighting, serializer: SightingSerializer
  end

  protected

  def sighting_params
    params.permit(:flower_id, :user_id, :name, :description, :latitude,
                  :longitude, :picture)
  end
end
