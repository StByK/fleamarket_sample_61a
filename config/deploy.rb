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


after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:stop'
    invoke 'unicorn:start'
  end
end

namespace :deploy do

  desc 'reload the database with seed data'
  task :seed do
    on roles(:db) do
      with rails_env: fetch(:rails_env) do
        within release_path do
          execute :bundle, :exec, :rake, 'db:seed'
        end
      end
    end
  end
  after  :migrate,      :seed
end


# rails runner db/category_seed.rb

# namespace :deploy do
#   desc 'Refresh Leads'
#   task :refresh_leads do
#     on roles(:app), in: :sequence, wait: 5 do
#       runner "Leads.refresh"
#     end
#   end
# end

# desc 'reset the database'
# task :db_reset do
#   on roles(:app) do
#     within release_path do
#       with rails_env: fetch(:rails_env) do
#         execute :rake, "db:migrate:reset"
#       end
#     end
#   end
# end

  # desc 'run the database with category seed data'
  # task :seed_category do
  #   on roles(:db) do
  #       with rails_env: fetch(:rails_env) do
  #         execute :rails, :runner, "db/category_seed.rb"
  #       end
  #     end
  #   end

  # after  :migrate,      :seed
  # after  :migrate,      :seed_category

