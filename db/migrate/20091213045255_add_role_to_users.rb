class AddRoleToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :role, :string, :default => 'service_provider', :null=> false
  end

  def self.down
    remove_column :users, :role
  end
end
