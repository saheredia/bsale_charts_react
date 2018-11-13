#carga el entorno
require File.expand_path('../config/environment.rb', __FILE__)

class UiService < Sinatra::Base
  require File.expand_path('../config/routes.rb', __FILE__)
  require File.expand_path('../config/helpers.rb', __FILE__)

  Encoding.default_external = Encoding::UTF_8
  Encoding.default_internal = Encoding::UTF_8

  configure do
    set :default_content, :html
    set :views, "#{settings.root}/app/views"
    set :static, true
    set :public_folder, "#{settings.root}/public"
    set :protection, false
    set :session_secret, 'imx_ws_2018'
    set :sessions, true
    set :app_config, YAML.load_file(File.expand_path('../config/settings.yml', __FILE__))[settings.environment.to_s]
    set :assets_version, File.open(File.expand_path('../config/assets.version', __FILE__)).read.to_s.gsub("\n", "") rescue "0"
    set :app_environment, settings.environment.to_s

    set :menu_owner, ''
    set :access_token, ""
    set :usr_token, ""
    set :cpn_id, 0

    unless settings.environment.to_s == 'production'
      Sass::Plugin.options[:style] = :compressed
      use Sass::Plugin::Rack
    end
  end

  before do
    # Setea que la respuesta de los request sean content_type 'application/html'
    content_type 'text/html', :charset => 'utf-8'
    # Define el cache de las peticiones
    expires 0, :public, :must_revalidate

    # Autentificar la peticion    
    unless authenticate!
      body(output_to_api('403', 'invalid token').to_json)
      halt 403
    end if request.path_info != '/ping'
  end

  after do
    UiService.settings.access_token = ""
    UiService.settings.usr_token = ""
    UiService.settings.cpn_id = 0
  end

  not_found do
    status 404
    #body(output_to_api(404, 'The requested resource is not available').to_json)
  end

  error do
    status 500
    #body(output_to_api(500, env['sinatra.error'].message).to_json)
  end

  get '/ping' do
    status 200
  end

end
