require 'typhoeus'
### Metodo encargado de manejar peticiones a servicios Rest
## Modo de uso:
## Api.call(url, { :method=>'GET', :body=>'', :headers=>{} })
class Api
  def self.call(url, args={})
    opts = { :method=>'GET', :body=>'', :headers=>{} }
    opts.merge!(args)
    req_headers = {}
    req_headers['Content-Type'] = 'application/json'
    req_headers.merge!(opts[:headers]) if opts.include?(:headers)
    begin
      request = Typhoeus::Request.new(
          url,
          method: opts[:method],
          body: opts[:body].to_json,
          headers: req_headers,
          timeout: 30
      )
      response = request.run
      result = JSON.parse(response.response_body, :symbolize_names => true)
      begin
        result.merge!(:success => response.success?) unless result.include?(:success)
      rescue
        result = {:data => result, :success => response.success?} unless result.include?(:success)
      end
      return result
    rescue Exception => e
      p e.backtrace
      return { :success => false, :error => e.message }
    end
  end
end
