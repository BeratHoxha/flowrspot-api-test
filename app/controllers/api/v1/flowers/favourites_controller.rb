# frozen_string_literal: true

class Api::V1::Flowers::FavouritesController < Api::V1::Flowers::BaseController
  def create
    @favorite = build_favorite

    @flowers = @current_user.favourite_flowers
                            .order(created_at: :asc)
                            .page(params[:page])
                            .per(params[:per_page])

    if @favorite.save
      render json: @flowers,
             root: :flowers,
             meta: generate_pagination(@flowers),
             each_serializer: FlowersSerializer
    else
      render json: { error: @favorite.errors.full_messages },
             status: :bad_request
    end
  end

  private

  def build_favorite
    Favourite.new(flower_id: @flower.id, user_id: @current_user.id)
  end
end
