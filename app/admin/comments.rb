# frozen_string_literal: true

ActiveAdmin.register Comment do
  menu priority: 6
  controller do
    def permitted_params
      params.permit(comment: %i[sighting_id user_id body])
    end
  end
end
