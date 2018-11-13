module Sinatra
  module Controllers
    module Example

      def self.registered(app)
        app.get '/example1' do
	        # Available Layouts:
	        # 	- 'app': card + sidenav
	        # 	- 'app_full_width': single card (centered)
	        # 	- 'app_clean': no card, just header
          return _render :template => '/example1/index', :layout => 'app'
        end

        app.get '/example2' do
	        # Available Layouts:
	        # 	- 'app': card + sidenav
	        # 	- 'app_full_width': single card (centered)
	        # 	- 'app_clean': no card, just header
          return _render :template => '/example2/index', :layout => 'app'
        end
        
        app.get '/example3' do
	        # Available Layouts:
	        # 	- 'app': card + sidenav
	        # 	- 'app_full_width': single card (centered)
	        # 	- 'app_clean': no card, just header
          return _render :template => '/example3/index', :layout => 'app'
        end

      end
    end
  end
end
