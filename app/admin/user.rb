# frozen_string_literal: true

ActiveAdmin.register User do
  menu priority: 3
  permit_params :id, :email, :first_name, :last_name, :date_of_birth, :profile_picture

  index do
    id_column

    column :id
    column :email
    column :first_name
    column :last_name
    column :date_of_birth
    column :profile_picture_file_name
    actions
  end

  form do |f|
    f.inputs 'New User' do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :first_name
      f.input :last_name
      f.input :date_of_birth, as: :datepicker
      f.input :profile_picture
    end
    f.actions
  end

  controller do
    def permitted_params
      params.permit user: %i[email password password_confirmation first_name last_name date_of_birth profile_picture]
    end
  end
end
