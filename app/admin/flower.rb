# frozen_string_literal: true

ActiveAdmin.register Flower do
  menu priority: 4
  permit_params :id, :name, :latin_name, :features, :description,
                :profile_picture, favorites_attributes: %i[id user_id _destroy]

  form do |f|
    f.inputs 'Flower' do
      f.input :name
      f.input :latin_name
      f.input :features
      f.input :description
      f.input :profile_picture
      f.actions
    end
  end

  index do
    id_column
    column :name
    column :latin_name
    column :features
    column :description
    column :profile_picture_file_name
    column 'Favourites Count' do |flower|
      flower.favourites.count
    end
    actions
  end

  show do
    attributes_table do
      row :name
      row :latin_name
      row :features
      row :description
      row :created_at
      row :updated_at
      row :profile_picture
    end
  end
end
