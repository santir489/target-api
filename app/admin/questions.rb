ActiveAdmin.register Question do
  controller do
    actions :index, :show, :destroy
  end

  index do
    selectable_column
    id_column
    column :email_from
    column :email_to
    column :sent
    column :user
    column :created_at
    actions
  end
end
