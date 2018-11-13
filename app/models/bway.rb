class Bway

  def self.base_url
    return "#{UiService.app_config['bway_api']}/v1/auth"
	end

  def self.check_user_credential(user_ip,user_credential)
    url = "#{base_url}/sign_in.json"
    return Api.call(url, { :method => 'POST', :body => {:userCredential => user_credential, :userIp => user_ip} })
  end

  def self.get_bsale_instances(atk)
    url = "#{base_url}/10/instances.json"
    return Api.call(url, { :method => 'GET', :headers => { :access_token => atk } })
  end

  def self.get_instance_token(cpn_id, atk)
    url = "#{base_url}/sign_in_instance.json"
    return Api.call(url, { :method => 'POST', :body => {:instanceId => cpn_id}, :headers => { :access_token => atk } })
  end

  def self.get_users_tks(atk,itk)
    url = "#{base_url}/users/sessions/#{itk}"
    auth = Api.call(url, { :method => 'GET', :headers => { :access_token => atk } })
    return { :success => false } unless auth[:success]
    {
      :success => true,
      :access_token => auth[:itk][:usr][:act],
      :user_id => auth[:atk][:usr][:id],
      :user_name => "#{auth[:atk][:usr][:firstName]} #{auth[:atk][:usr][:lastName]}",
      :user_token => auth[:atk][:usr][:userToken],
      :url_bsale => auth[:itk][:cpn][:webHost].gsub!(/\/$/, ""),
      :bway_token => auth[:bwt],
      :db_name => auth[:itk][:cpn][:dbName],
      :cpn_id => auth[:itk][:cpn][:id],
      :cpn_name => auth[:itk][:cpn][:name],
      :db_ip => auth[:itk][:cpn][:dbIp]
    }
  end

  def self.unlock_jump(atk)
    url = "#{base_url}/unlock_jump.json"
    return Api.call(url, { :method => 'PUT', :headers => { :access_token => atk } })
  end

  def self.atk_blacklist(atk)
    url = "#{base_url}/blacklist.json"
    return Api.call(url, { :body => {:accessToken => atk }.to_json, :method => 'post' })
  end

  def self.get_status(access_token)
    url = "#{base_url}/status.json"
    return Api.call(url, { :method => 'GET', :headers => { :access_token => access_token } })
  end
end
