#En caso de estar usan Unicorn
if defined?(Unicorn)
  #Si los limites de memoria son superiores a los definidos (rango de 350 a 400 MB por worker), el worker sera reiniciado
  require 'unicorn/worker_killer'
  oom_min = (100) * (1024**2)
  oom_max = (200) * (1024**2)
  use Unicorn::WorkerKiller::Oom, oom_min, oom_max
end

#carga y levanta la aplicacion
require File.expand_path('../ui_service', __FILE__)
run UiService
