set :application, "tc"

default_run_options[:pty] = true  # Must be set for the password prompt from git to work
set :repository, "git@github.com:rbsilva/tc-alr.git"  # Your clone URL
set :scm, "git"
set :branch, "master"
set :deploy_via, :remote_cache
set :user, "deploy"
set :scm_passphrase, "742147"  # The deploy user's password
set :use_sudo, false

server "unip.servehttp.com:465", :app, :web, :db, :primary => true
set :deploy_to, "/srv/ruby/tc"

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts