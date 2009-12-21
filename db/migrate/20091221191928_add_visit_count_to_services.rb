class AddVisitCountToServices < ActiveRecord::Migration
  def self.up
    add_column :services, :visit_count, :integer, :default => 0
  end

  def self.down 
    remove_column :services, :visit_count 
  end
end
