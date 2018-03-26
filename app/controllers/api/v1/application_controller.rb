class Api::V1::ApplicationController < ActionController::API

  def generate_pagination(paginated_obj)
    # current page, previous page, next page, total pages
    {
      pagination: {
        # ....
      }
    }
  end
end
