class CreateServices < ActiveRecord::Migration
  def self.up
    create_table :services do |t|
      t.integer :service_category_id
      t.integer :service_provider_id
      t.text :service_description
      t.string :type
      t.timestamps
    end
  end
  
  def self.down
    drop_table :services
  end
end
