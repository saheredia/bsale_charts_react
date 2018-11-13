# set path to app that will be used to configure unicorn,
# note the trailing slash in this example
app_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

worker_processes 2
working_directory app_root
timeout 30
preload_app true
check_client_connection true

# Specify path to socket unicorn listens to,
# we will use this in our nginx.conf later
listen "#{app_root}/tmp/sockets/unicorn.sock", :backlog => 64

# Set process id path
pid "#{app_root}/tmp/pids/unicorn.pid"

# Set log file paths
stderr_path "#{app_root}/log/unicorn.stderr.log"
stdout_path "#{app_root}/log/unicorn.stdout.log"

before_exec do |server|
  ENV['BUNDLE_GEMFILE'] = "#{app_root}/Gemfile"
end

before_fork do |server, worker|
# This option works in together with preload_app true setting
# What is does is prevent the master process from holding
  old_pid = "#{server.config[:pid]}.oldbin"
  if old_pid != server.pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end

  # Throttle the master from forking too quickly by sleeping.
  sleep 2
end
