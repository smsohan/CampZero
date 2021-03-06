task :staging do
  set :application, "CampZero"
  set :deploy_to, "~/app"
  set :use_sudo, true
  set :scm_verbose, true
  set :rails_env, "staging"
  set :user, "webmaster"
  set :domain, "www.campzero.com"
  server domain, :app, :web
  role :db, domain, :primary => true
  set :scm, :git
  set :branch, "master"
  set :repository, "	git://github.com/smsohan/CampZero.git"
  set :deploy_via, :remote_cache
  namespace :passenger do
    desc "Restart Application"
    task :restart, :roles => :app do
      run "touch #{current_path}/tmp/restart.txt"
    end
  end
  namespace :deploy do
    %w(start restart).each { |name| task name, :roles => :app do passenger.restart end }
    desc "change owner and rename the public folder to web"
    task :after_update_code, :roles => :app do
      run "mv #{release_path}/public #{release_path}/web"
      run "mkdir -p #{shared_path}/assets; ln -s #{shared_path}/assets #{release_path}/web/attached_files"
      run "ln -s #{shared_path}/config/database.yml #{release_path}/config/database.yml"
      run "ln -s #{shared_path}/config/#{rails_env}.sphinx.conf #{release_path}/config/#{rails_env}.sphinx.conf"
      run "ln -s #{shared_path}/sitemap/sitemap.xml #{release_path}/web/sitemap.xml"
      thinking_sphinx.rebuild
    end
    
  end
end