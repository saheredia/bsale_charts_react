module Sinatra
  module Controllers
    module Charts

      def self.registered(app)
        app.get '/charts' do
	        # Available Layouts:
	        # 	- 'app': card + sidenav
	        # 	- 'app_full_width': single card (centered)
	        # 	- 'app_clean': no card, just header
          return _render :template => '/charts/index', :layout => 'app'
        end
      end
    end
  end
end
