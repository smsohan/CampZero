task :staging do
  set :application, "CampZero"
  set :deploy_to, "~/app"
  set :use_sudo, false
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
      run "sudo chown -R apache #{current_path}"
      run "sudo mv #{current_path}/public #{current_path}/web"
    end
    #desc "Symlink the pictures directory"
    #task :after_update_code, :roles => :app do
    #  run "ln -s #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    #  run "mkdir -p #{shared_path}/assets; ln -s #{shared_path}/assets #{release_path}/assets"
    #  run "cd #{current_path} &&" + "RAILS_ENV=#{rails_env} rake ts:config"
    #  run "cd #{current_path} &&" + "RAILS_ENV=#{rails_env} rake ts:in"
    #end
  end
end