# frozen_string_literal: true

class Api::V1::Users::SightingsController < Api::V1::Users::BaseController
  skip_before_action :authenticate_api_user

  def index
    @sightings = Sighting.where(user_id: @user.id)
                         .page(params[:page])
                         .per(params[:per_page])

    render json: @sightings,
           root: :sightings,
           meta: generate_pagination(@sightings),
           each_serializer: SightingsSerializer
  end
end
