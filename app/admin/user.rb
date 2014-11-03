ActiveAdmin.register User do
  menu priority: 1
  filter :email
  filter :full_name
  filter :created_at

  index do
    column :id
    column :email
    column :full_name
    column :created_at
    actions
  end

  show do
    panel "User Details" do
      attributes_table_for user do
        row(:email)
        row(:full_name)
        row(:created_at)
      end
    end
    panel 'Additional information' do
      attributes_table_for user do
        row(:sign_in_count)
        row(:current_sign_in_at)
        row(:last_sign_in_at)
        row(:current_sign_in_ip)
        row(:last_sign_in_ip)
      end
    end
    active_admin_comments
  end

  form do |f|
    f.inputs "Details" do
      f.input :email
      f.input :full_name
    end
    f.buttons
  end

  controller do
    def permitted_params
      params.permit user: [:email, :full_name]
    end
  end
end
