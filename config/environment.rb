#Deja los archivos ubicados en 'app' en el PATH
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'app'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'boot.rb'
require 'sass/plugin/rack'
require 'sinatra'
require 'sinatra/base'
require "sinatra/cookies"

require 'sinatra/content_for'
require 'sinatra/outputbuffer'

require 'oj'
require 'oj_mimic_json'
require 'yaml'
require 'newrelic_rpm'
require 'pry'
#carga helpers
Dir[File.expand_path('../../app/helpers/*.rb', __FILE__)].each do |f|
  require f
end

#cargar controllers
Dir[File.expand_path('../../app/controllers/*.rb', __FILE__)].each do |f|
  require f
end

#Modelos
Dir[File.expand_path('../../app/models/*.rb', __FILE__)].each do |f|
  require f
end
