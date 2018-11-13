class Menu

  def self.get(menu_id)
    url = "#{UiService.settings.app_config['menu_api']}/v1/menu/#{menu_id}.json"
    result = Api.call(url, { :headers => { 'access_token' => UiService.settings.access_token } })
    if result[:success]
      return result[:data]
    else
      return []
    end
  end

  def self.get_domain(owner)
    url = "#{UiService.settings.app_config['menu_api']}/v1/menu/owner/#{owner}.json"
    result = Api.call(url, { :headers => { 'access_token' => UiService.settings.access_token } })
    if result[:success]
      return result[:data][:domain].to_s
    else
      return ""
    end
  end

end
