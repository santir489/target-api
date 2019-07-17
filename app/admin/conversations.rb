ActiveAdmin.register Conversation do
  controller do
    actions :index, :show
  end

  filter :users

  index do
    selectable_column
    id_column
    column :users do |conversation|
      conversation.users.map { |user| link_to(user.email, admin_user_path(user)) }
    end
    actions
  end

  show do
    attributes_table do
      row :id
      row :users do |conversation|
        conversation.users.map { |user| link_to(user.email, admin_user_path(user)) }
      end
      row :created_at
      row :updated_at
    end

    panel 'Messages' do
      table_for conversation.messages do
        column :id
        column :text
        column :user do |message|
          message.user_email
        end
        column :created_at
      end
    end
  end
end
