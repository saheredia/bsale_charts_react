def authenticate!
  #return true
  return true if check_token
  if cookies['atk'].to_s.strip.length > 0
    responde = Bway.get_status(cookies['atk'])
    if responde[:success]
      set_app_settings
      return true
    end
  end
  return false
end

def check_token
  return false if !(params[:itk].to_s.strip.length > 0 && params[:atk].to_s.strip.length > 0)
  auth = Bway.get_users_tks(params[:atk].to_s, params[:itk])
  return false unless auth[:success]

  cookies['atk'] = params[:atk]
  cookies['itk'] = params[:itk]
  session['access_token'] = auth[:access_token]
  session['user_token'] = auth[:user_token]
  session['cpn_id'] = auth[:cpn_id]
  set_app_settings

  session['user_id'] = auth[:user_id]
  session['user_name'] = auth[:user_name]

  session['bway_token'] = auth[:bway_token]

  session['cpn_name'] = auth[:cpn_name]
  session['active'] = 1
  session['office_id'] = params[:office_id].to_i

  of = BsOffice.new
  of.get(session['office_id'])
  session['office_name'] = of.office_name
  session['mk_id'] = params[:mk_id].to_i
  session['origin'] = params[:origin] unless params[:origin].blank?

  return true
end

def set_app_settings
  UiService.settings.access_token = session['access_token']
  UiService.settings.usr_token = session['user_token']
  UiService.settings.cpn_id = session['cpn_id']
end
