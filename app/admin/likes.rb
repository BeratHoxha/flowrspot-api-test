# frozen_string_literal: true

ActiveAdmin.register Like do
  menu priority: 7
  controller do
    def permitted_params
      params.permit(like: %i[sighting_id user_id])
    end
  end
end
