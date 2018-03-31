# frozen_string_literal: true

class Api::V1::FavouritesController < Api::V1::BaseController
  def index
    @flowers = @current_user.favourite_flowers
                            .order(created_at: :asc)
                            .page(params[:page])
                            .per(params[:per_page])

    render json: @flowers,
           root: :flowers,
           meta: generate_pagination(@flowers),
           each_serializer: FlowersSerializer
  end
end
