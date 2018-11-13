class BsOffice
  attr_accessor :office_name, :office_id

  def initialize
    @office_name = ""
    @office_id = 0
    @url = "#{UiService.settings.app_config['bsale_api']}/v1/offices"
	end

  def get(office_id)
    url = "#{@url}/#{office_id}.json"
    result = Api.call(url, { :headers => { 'access_token' => UiService.settings.access_token } })
    if result[:success]
      @office_name = result[:name].to_s
      @office_id = result[:id].to_i
    end
  end

  def get_all
    url = "#{@url}.json?state=0"
    result = Api.call(url, { :headers => { 'access_token' => UiService.settings.access_token } })
    if result[:success]
      result
    end
  end

end
