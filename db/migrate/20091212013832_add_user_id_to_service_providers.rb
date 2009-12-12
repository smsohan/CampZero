class AddUserIdToServiceProviders < ActiveRecord::Migration
  def self.up
    add_column :service_providers, :user_id, :integer
  end

  def self.down
    remove_column :service_providers, :user_id
  end
end
