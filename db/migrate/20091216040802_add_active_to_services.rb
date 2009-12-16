class AddActiveToServices < ActiveRecord::Migration
  def self.up
    add_column :services, :active, :boolean, :default => true
  end

  def self.down
    remove_column :services, :active
  end
end
