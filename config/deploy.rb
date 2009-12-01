set :application, "pastehost"
set :repository, "git://github.com/aaronbieber/pastehost.git"

task :new do
	set :domain, "diagramwar.com"
	set :deploy_to, "/var/www/pastehost.com/pastehost"
end

task :current do
	set :domain, "pastehost.com"
	set :deploy_to, "/var/www/pastehost.com/pastehost"
end
