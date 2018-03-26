class Api::V1::Users::SightingsController < Api::V1::Users::BaseController
  skip_before_action :authenticate_api_user

  def index
    # return only users sightings
  end
end
