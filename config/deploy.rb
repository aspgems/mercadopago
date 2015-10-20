# config valid only for Capistrano 3.1
lock '3.2.1'

set :client, 'spainselect'
set :application, 'servicios'

set :repo_url, "git@bitbucket.org:aspgems/#{fetch(:client)}-#{fetch(:application)}.git"

set :user, 'spainselectservicios'
set :deploy_to, -> { "/home/#{fetch(:user)}/app" }
set :keep_releases, 5

set :linked_files, %w(config/database.yml config/chamber.pem)
set :linked_dirs, %w(bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system sphinx)
# Files that won't be copied from script/deploy/{branch}/ into the root directory
set :exclude_deployment_files, []

set :ssh_options, lambda {
  {
    user: fetch(:user),
    forward_agent: true
  }
}

set :rails_env, 'production'
set :scm, :git
set :log_level, :info

# capistrano-db-tasks related
# if you want to remove the dump file after loading
set :db_local_clean, true
# If you want to import assets, you can change default asset dir (default = system)
# This directory must be in your shared directory on the server
set :assets_dir, %w(public/assets)
# if you want to work on a specific local environment (default = ENV['RAILS_ENV'] || 'development')
set :locals_rails_env, "development"

# Rollbar deployment notification.
set :rollbar_env,   -> { fetch(:app_env) }
set :rollbar_token, lambda {
  file = File.expand_path("../script/deploy/#{fetch(:instance)}/config/settings/rollbar.yml", File.dirname(__FILE__))
  YAML.load_file(file)[fetch(:rails_env)]['rollbar'][:access_token]
}

# Sidekiq
set :sidekiq_role,    -> { :sidekiq }
set :sidekiq_options, -> { "-e #{fetch(:rails_env, 'production')} -L #{current_path}/log/sidekiq.log -C config/sidekiq.yml" }
set :sidekiq_pid,     -> { "#{current_path}/tmp/pids/sidekiq.pid" }
set :sidekiq_proccess_name, -> { "sidekiq_#{fetch(:client)}#{fetch(:application)}" }

# Newrelic
set :newrelic_revision,    -> { fetch(:current_revision) }

# Hipchat notification
set :hipchat_token, '77336b5d1c0704efe157e97e8cb04c'
set :hipchat_room_name, 'spainselect-servicios'
set :hipchat_announce, true # notify users?
set :hipchat_env, -> { fetch(:instance) }

set :rollbar_token, '3a21c785160748219d59566a49d0a2c1'
set :rollbar_env, Proc.new { fetch :stage }
set :rollbar_role, Proc.new { :app }

namespace :deploy do
#  before :finished, 'deploy:sitemap:refresh'
  after :updated, 'newrelic:notice_deployment'
end
