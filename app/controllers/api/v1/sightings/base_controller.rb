class Api::V1::Sightings::BaseController < Api::V1::BaseController
  before_action :set_sighting

  protected

  def set_sighting
    @sighting = Sighting.find params[:sighting_id]
  end
end
