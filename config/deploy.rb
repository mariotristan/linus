require "bundler/capistrano"

set :application,           "linus"
set :repository,            "git://github.com/pygatea/linus.git"
set :branch,                "master"

set :user,                  "deployer"
set :group,                 "deployer"
set :use_sudo,              false
set :ssh_options,           { :forward_agent => true, :keys => [File.join(ENV["HOME"], ".ssh", "deploylinus")]}

set :deploy_to,             "/home/deployer/apps/linus"
set :deploy_via,            :remote_cache
set :scm, :git

set :rails_env,             "production"
set :normalize_asset_timestamps, false
role :web,                  "linus.chicagoshadydealer.com" # Your HTTP server, Apache/etc
role :app,                  "linus.chicagoshadydealer.com" # This may be the same as your `Web` server
role :db,                   "linus.chicagoshadydealer.com", :primary => true # This is where Rails migrations will run

default_environment["RAILS_ENV"]  = 'production'
default_environment["PATH"]  = "/var/lib/gems/1.8/bin:$PATH"
default_run_options[:shell]       = 'bash'
default_run_options[:pty]         = true

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
