class CreateServiceCategories < ActiveRecord::Migration
  def self.up
    create_table :service_categories do |t|
      t.string :name
      t.integer :parent_id

      t.timestamps
    end
  end

  def self.down
    drop_table :service_categories
  end
end
