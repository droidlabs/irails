ActiveAdmin.register AdminUser do
  filter :email
  
  index do
    column :id
    column :email
    column :created_at
    default_actions
  end
  
  show do
    panel "Admin User Details" do
      attributes_table_for(admin_user, :id, :email, :created_at)
    end
  end
  
  form do |f|
    f.inputs "Details" do
      f.input :email
      f.input :password
    end
    f.buttons
  end
end