set :application, "tc"
set :repository,  "https://unip.servehttp.com:444/svn_unip/tc"

set :scm, :subversion
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :user, "deploy"
set :use_sudo, false

#role :web, "unip.servehttp.com:42"                          # Your HTTP server, Apache/etc
#role :app, "unip.servehttp.com:42"                          # This may be the same as your `Web` server
#role :db,  "unip.servehttp.com:42", :primary => true # This is where Rails migrations will run

server "unip.servehttp.com:42", :app, :web, :db, :primary => true
set :deploy_to, "/srv/ruby/tc"

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:assets:precompile", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
     namespace :assets do
       task :precompile, :roles => :web, :except => { :no_release => true } do
           run %Q{cd #{latest_release}/trunk && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile}
     end
   end
 end