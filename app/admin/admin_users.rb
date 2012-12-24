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

  controller do
    def update
      @admin_user = AdminUser.find(params[:id])
      password_changed = params[:admin_user][:password].present?

      successfully_updated = if password_changed
        @admin_user.update_attributes(params[:admin_user])
      else
        @admin_user.update_without_password(params[:admin_user])
      end

      if successfully_updated
        redirect_to admin_admin_user_path(@admin_user)
      else
        render :edit
      end
    end
  end

  form do |f|
    f.inputs "Details" do
      f.input :email
      f.input :password, hint: "Keep blank if you won't change password"
    end
    f.buttons
  end
end