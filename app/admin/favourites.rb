# frozen_string_literal: true

ActiveAdmin.register Favourite do
  menu priority: 8
  controller do
    def permitted_params
      params.permit(favourite: %i[user_id flower_id])
    end
  end
end
