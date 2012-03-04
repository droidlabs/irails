ActiveAdmin.register User do
  filter :email
  filter :full_name
  filter :created_at

  index do
    column :id
    column :email
    column :full_name
    column :created_at
    default_actions
  end

  show do
    panel "User Details" do
      attributes_table_for(user,
        :email, :full_name, :created_at, :last_sign_in_at
      )
    end
  end

  form do |f|
    f.inputs "Details" do
      f.input :email
      f.input :full_name
    end
    f.buttons
  end
end
