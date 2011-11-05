class CreateAdminComments < ActiveRecord::Migration
  def self.up
    create_table :active_admin_comments do |t|
      t.references :resource, :polymorphic => true, :null => false
      t.references :author, :polymorphic => true
      t.text :body
      t.string :namespace
      t.timestamps
    end
    add_index :active_admin_comments, [:resource_type, :resource_id]
    add_index :active_admin_comments, [:author_type, :author_id]
    add_index :active_admin_comments, [:namespace]
  end

  def self.down
    drop_table :active_admin_comments
  end
end
