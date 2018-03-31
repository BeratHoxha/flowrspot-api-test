# frozen_string_literal: true

class Api::V1::Flowers::ImagesController < Api::V1::Flowers::BaseController
  def index
    @images = @flower.images.page(params[:page]).per(params[:per_page])
    render json: @images,
           root: :images,
           meta: generate_pagination(@images),
           each_serializer: ImageSerializer
  end
end
