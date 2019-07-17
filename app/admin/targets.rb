ActiveAdmin.register Target do
  permit_params :topic, :title, :length, :user_id, :latitude, :longitude

  index do
    selectable_column
    id_column
    column :topic
    column :title
    column :length
    column :user
    column :latitude
    column :longitude
    actions
  end

  filter :email

  form do |f|
    f.inputs do
      f.input :topic
      f.input :title
      f.input :length
      f.input :user
      f.input :latitude
      f.input :longitude
    end
    f.actions
  end
end
