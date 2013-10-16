require File.expand_path('../../config/environment',  __FILE__)
 
set :application, Rails.application.class.parent_name.downcase
set :hostname, YAML.load_file(File.join(File.dirname(__FILE__), 'settings.yml'))['host'] 

set :repo_url, 'https://github.com/nning/moeil.git'
set :scm, :git

set :rbenv_type, :user
set :rbenv_ruby, '2.0.0-p247'

set :deploy_to,  '/srv/http/' + fetch(:hostname)
set :deploy_via, :remote_cache

set :log_level, :info

set :linked_files, %w[config/database.yml config/initializers/secret_token.rb]
set :linked_dirs, %w[bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system]

set :keep_releases, 5


namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles :app, in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :finishing, 'deploy:cleanup'

end
