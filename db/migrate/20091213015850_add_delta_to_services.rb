class AddDeltaToServices < ActiveRecord::Migration
  def self.up
    add_column :services, :delta, :boolean, :default => true, :null => false
  end

  def self.down
    remove_column :services, :delta
  end
end
