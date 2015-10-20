#!/usr/bin/env puma

daemonize false

pidfile 'tmp/pids/puma.pid'
state_path 'tmp/pids/puma.state'

threads 0,16

preload_app!

bind 'unix:///tmp/desman.sock'
environment 'production'

preload_app!

activate_control_app 'unix://tmp/sockets/pumactl.sock'

on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end
end
