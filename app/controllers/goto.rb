module Sinatra
  module Controllers
    module Goto
      def self.registered(app)
        app.get '/goto' do
          owner = params[:owner].to_s
          menu_url = params[:url].to_s
          redirect menu_url and return if owner == UiService.settings.menu_owner
          domain = Menu.get_domain(owner)
          goto_url = "#{domain}#{menu_url}"
          separator = "?"
          separator = "&" if goto_url.to_s.include?("?")
          url = "#{goto_url}#{separator}bway_token=#{session['bway_token']}&cpn=#{session['cpn_id']}&c=#{session['cpn_id']}&office_id=#{session['office_id']}&mk_id=#{session['mk_id'].to_i}"
          Bway.unlock_jump(cookies[:atk])
          url = "#{url}&atk=#{cookies[:atk]}&itk=#{cookies[:itk]}"
          redirect url and return
        end

        app.get '/logout' do
          session['access_token'] = nil
          session['user_token'] = nil
          session['cpn_id'] = nil
          session['user_id'] = nil
          session['user_name'] = nil

          session['url_bsale'] = nil
          session['bway_token'] = nil

          session['cpn_name'] = nil
          session['active'] = 0
          session['office_id'] = nil
          session['office_name'] = nil
          session['mk_id'] = 0
          session['origin'] = nil

          redirect 'https://app2.bsale.cl/logout'
        end
      end

    end
  end
end
