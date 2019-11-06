# config valid only for current version of Capistrano


lock '3.11.2'

set :application, 'fleamarket_sample_61a'
set :repo_url,  'git@github.com:StByK/fleamarket_sample_61a.git'

set :branch, "development"

set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')
set :rbenv_type, :user
set :rbenv_ruby, '2.5.1'

set :ssh_options, auth_methods: ['publickey'],
                  keys: ['~/.ssh/ex61.pem']

set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" }

set :unicorn_config_path, -> { "#{current_path}/config/unicorn.rb" }
set :keep_releases, 5


namespace :deploy do
  desc 'db_seed must be run only one time right after the first deploy'
  task :db_seed do
    on roles(:db) do |host|
      within current_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'db:seed'
        end
      end
    end
  end
end



after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:stop'
    invoke 'unicorn:start'
  end
end

# namespace :deploy do
#   desc "reload the database with seed data"
#   task :seed do
#     run "cd #{current_path}; bundle exec rake db:seed RAILS_ENV=#{rails_env}"
#   end
# end


# # webサーバー再起動時にキャッシュを削除
# after :restart, :clear_cache do
#   on roles(:web), in: :groups, limit: 3, wait: 10 do
#     # Here we can do anything such as:
#     within release_path do
#       execute :rm, '-rf', release_path.join('tmp/cache')
#     end
#   end
# end