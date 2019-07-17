ActiveAdmin.register User do
  controller do
    actions :index, :show, :destroy
  end

  permit_params :email

  filter :email

  index do
    selectable_column
    id_column
    column :email
    actions
  end
end
