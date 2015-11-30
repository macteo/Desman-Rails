#!/usr/bin/env puma

# daemonize false
#
# pidfile 'tmp/pids/puma.pid'
# state_path 'tmp/pids/puma.state'
#
# threads 0,16
#
# preload_app!
#
# bind 'unix:///tmp/desman.sock'
# environment 'production'
#
# preload_app!
#
# activate_control_app 'unix://tmp/sockets/pumactl.sock'
#
# on_worker_boot do
#   ActiveSupport.on_load(:active_record) do
#     ActiveRecord::Base.establish_connection
#   end
# end


workers Integer(ENV['PUMA_WORKERS'] || 3)
threads Integer(ENV['MIN_THREADS']  || 1), Integer(ENV['MAX_THREADS'] || 16)

preload_app!

rackup      DefaultRackup
port        ENV['PORT']     || 3000
environment ENV['RACK_ENV'] || 'development'

on_worker_boot do
  # worker specific setup
  ActiveSupport.on_load(:active_record) do
    config = ActiveRecord::Base.configurations[Rails.env] ||
             Rails.application.config.database_configuration[Rails.env]
    config['pool'] = ENV['MAX_THREADS'] || 16
    ActiveRecord::Base.establish_connection(config)
  end
end
