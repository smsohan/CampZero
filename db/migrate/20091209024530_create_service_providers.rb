class CreateServiceProviders < ActiveRecord::Migration
  def self.up
    create_table :service_providers do |t|
      t.string :name
      t.string :phone
      t.string :fax
      t.string :mobile
      t.string :email
      t.belongs_to :service_provider_category
      t.timestamps
    end
  end
  
  def self.down
    drop_table :service_providers
  end
end
