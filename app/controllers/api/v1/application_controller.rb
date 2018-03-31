# frozen_string_literal: true

class Api::V1::ApplicationController < ActionController::API
  def generate_pagination(paginated_obj)
    {
      pagination: {
        current_page: paginated_obj.current_page,
        next_page: paginated_obj.next_page,
        previous_page: paginated_obj.prev_page,
        total_pages: paginated_obj.total_pages
      }
    }
  end
end