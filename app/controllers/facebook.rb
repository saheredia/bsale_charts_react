module Sinatra
  module Controllers
    module Facebook

      def self.registered(app)
        app.get '/facebook' do
	        # Available Layouts:
	        # 	- 'app': card + sidenav
	        # 	- 'app_full_width': single card (centered)
	        # 	- 'app_clean': no card, just header
          return _render :template => '/facebook/index', :layout => 'app'
        end
      end
    end
  end
end
