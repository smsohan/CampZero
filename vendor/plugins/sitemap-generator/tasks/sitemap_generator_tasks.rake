require File.join(File.dirname(__FILE__), '/../lib/sitemap_generator')

namespace :sitemap do

  desc "Generates the sitemap"
  task :generate do
    require(File.join(RAILS_ROOT, 'config', 'environment'))

    # Finds models and generates the sitemap
    if defined?(SITEMAP_FILE_PATH) 
      SitemapGenerator::Generator.new(SITEMAP_FILE_PATH).find_models_and_generate
    else
      SitemapGenerator::Generator.run 
    end  
    
    # You can also generate a sitemap 'manually' like this:
=begin
    SitemapGenerator::Generator.generate 'config' do |host, data|
      Post.all(:order => 'created_at desc', :limit => 5000).each do |post|
        data.add post, 0.7, :monthly
      end

      Category.all(:order => 'created_at desc', :limit => 5000).each do |category|
        data.add category, 0.6, :weekly
      end

      Tag.all(:order => 'created_at desc', :limit => 5000).each do |tag|
        data.add tag, 0.5, :weekly
      end
    end
=end
  end

end
