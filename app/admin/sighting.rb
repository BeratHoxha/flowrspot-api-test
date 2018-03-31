# frozen_string_literal: true

ActiveAdmin.register Sighting do
  menu priority: 5
  permit_params :id, :flower_id, :user_id, :name, :description, :latitude,
                :longitude, :created_at, :updated_at, :picture,
                likes_attributes: %i[id _destroy user_id created_at updated_at],
                comments_attributes: %i[id _destroy user_id content created_at updated_at]

  form do |f|
    f.inputs 'Sighting' do
      f.input :flower
      f.input :user
      f.input :name
      f.input :description
      f.input :latitude
      f.input :longitude
      f.input :picture
    end

    f.actions
  end

  index do
    id_column
    column :flower
    column :user
    column :name
    column :description
    column :latitude
    column :longitude
    column :picture

    column 'Comments Count' do |sighting|
      sighting.comments.count
    end

    column 'Likes Count' do |sighting|
      sighting.likes.count
    end
    actions
  end

  show do
    attributes_table do
      row :flower
      row :user
      row :name
      row :description
      row :latitude
      row :longitude
      row :created_at
      row :updated_at
      row :picture_file_name
      row :picture_content_type
      row :picture_file_size
      row :picture_updated_at
    end
  end
end
