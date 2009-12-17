class AverageRating < ActiveRecord::Migration
  def self.up
    add_column :services, :average_rating, :float

    Service.all.each do |service|
      if service.ratings_count
        service.average_rating = service.rate_avg 1
        service.save!
      end
    end
  end

  def self.down
    remove_column :services, :average_rating
  end
end
