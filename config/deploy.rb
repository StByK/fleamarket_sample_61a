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

set :default_env, {
  rbenv_root: "/usr/local/rbenv",
  path: "/usr/local/rbenv/shims:/usr/local/rbenv/bin:$PATH",
  AWS_ACCESS_KEY_ID: ENV["AWS_ACCESS_KEY_ID"],
  AWS_SECRET_ACCESS_KEY: ENV["AWS_SECRET_ACCESS_KEY"],
  BASIC_AUTH_USER: ENV["BASIC_AUTH_USER"],
  BASIC_AUTH_PASSWORD: ENV["BASIC_AUTH_PASSWORD"]
}

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:stop'
    invoke 'unicorn:start'
  end
end

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end

# NOTE: seedファイル読み込みが必要な場合のみコメントアウトはずして使用
# namespace :deploy do

#   desc 'reload the database with seed data'
#   task :seed do
#     on roles(:db) do
#       with rails_env: fetch(:rails_env) do
#         within release_path do
#           execute :bundle, :exec, :rake, 'db:seed'
#         end
#       end
#     end
#   end
#   after  :migrate,      :seed
# end